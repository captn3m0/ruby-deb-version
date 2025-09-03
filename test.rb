# frozen_string_literal: true

require "minitest/autorun"
require "deb_version"

# Tests
class DebVersionTest < Minitest::Test
  VERSIONS_FIXTURE = File.readlines("all-debian-versions.lst").map(&:strip)
  def to_a(version)
    v_(version).to_a
  end

  def v_(version)
    DebVersion.new(version)
  end

  def test_create_version
    assert_equal to_a("1:0.5"), [1, "0.5", ""]
    assert_equal to_a("0.5"), [0, "0.5", ""]
    assert_equal to_a("0.5-1"), [0, "0.5", "1"]
    assert_equal to_a("0.5-1~exp1"), [0, "0.5", "1~exp1"]
    assert_equal to_a("1:0.5-1~exp1"), [1, "0.5", "1~exp1"]
    assert_equal to_a("17"), [0, "17", ""]
    assert_equal to_a("17-2"), [0, "17", "2"]
    assert_equal to_a("17-2-3"), [0, "17-2", "3"]
  end

  def test_parse_lots_of_versions
    VERSIONS_FIXTURE.each do |version|
      v_(version)
    end
  end

  # rubocop:disable Metrics/AbcSize
  def test_equality
    assert v_("1") == v_("1")
    assert v_("1.0") == v_("1.0")
    assert v_("2:1.0") == v_("2:1.0")

    assert v_("0.01") == v_("0.1")
    assert_equal v_("0.01") <=> v_("0.1"), 0

    assert v_("0.0.5-1") == v_("0.00.05-1")
    assert_equal v_("0.0.5-1") <=> v_("0.00.05-1"), 0
  end

  # Ref: https://github.com/xolox/python-deb-pkg-tools/blob/a3d6ef1d82c6342b6a57876fc2360875e033f8f0/deb_pkg_tools/tests.py#L410
  def test_compare_versions
    assert v_("1.0") > v_("0.5")      # usual semantics
    assert v_("1:0.5") > v_("2.0")    # unusual semantics
    refute v_("0.5") > v_("2.0") # sanity check
    # Test the Debian '>=' operator.
    assert v_("0.75") >= v_("0.5")     # usual semantics
    assert v_("0.50") >= v_("0.5")     # usual semantics
    assert v_("1:0.5") >= v_("5.0")    # unusual semantics
    refute v_("0.2") >= v_("0.5") # sanity check
    # Test the Debian '<<' operator.
    assert v_("0.5") < v_("1.0")      # usual semantics
    assert v_("2.0") < v_("1:0.5")    # unusual semantics
    refute v_("2.0") < v_("0.5") # sanity check
    # Test the Debian '<=' operator.
    assert v_("0.5") <= v_("0.75")     # usual semantics
    assert v_("0.5") <= v_("0.50")     # usual semantics
    assert v_("5.0") <= v_("1:0.5")    # unusual semantics
    refute v_("0.5") <= v_("0.2") # sanity check
    # # Test the Debian '=' operator.
    assert v_("42") == v_("42")        # usual semantics
    assert v_("0.5") == v_("0:0.5")    # unusual semantics
    refute v_("0.5") == v_("1.0") # sanity check
    # Test the Python '!=' operator.
    assert v_("1") != v_("0") # usual semantics
    refute v_("0.5") != v_("0:0.5") # unusual semantics
    # Test the handling of the '~' token.
    assert v_("1.3~rc2") < v_("1.3")

    # The following tests come via go-deb-version

    # RedHat
    assert v_("7.4.629-3") < v_("7.4.629-5")
    assert v_("7.4.622-1") < v_("7.4.629-1")
    assert v_("6.0-4.el6.x86_64") < v_("6.0-5.el6.x86_64")
    assert v_("6.0-4.el6.x86_64") < v_("6.1-3.el6.x86_64")
    refute v_("7.0-4.el6.x86_64") < v_("6.1-3.el6.x86_64")

    # Debian
    assert v_("2:7.4.052-1ubuntu3") < v_("2:7.4.052-1ubuntu3.1")
    assert v_("2:7.4.052-1ubuntu2") < v_("2:7.4.052-1ubuntu3")
    assert v_("2:7.4.052-1") < v_("2:7.4.052-1ubuntu3")
    assert v_("2:7.4.052") < v_("2:7.4.052-1")
    assert v_("1:7.4.052") < v_("2:7.4.052")
    refute v_("1:7.4.052") < v_("7.4.052")
    refute v_("2:7.4.052-1ubuntu3.2") < v_("2:7.4.052-1ubuntu3.1")
    refute v_("2:7.4.052-1ubuntu3.1") < v_("2:7.4.052-1ubuntu3")
    refute v_("2:7.4.052-1ubuntu3") < v_("2:7.4.052-1ubuntu2")
    refute v_("2:7.4.052-1ubuntu1") < v_("2:7.4.052-1")
    assert v_("2:6.0-9ubuntu1.4") < v_("2:6.0-9ubuntu1.5")
    refute v_("2:7.4.052-1ubuntu") < v_("2:7.4.052-1")
    assert v_("6.4.052") < v_("7.4.052")
    assert v_("6.4.052") < v_("6.5.052")
    assert v_("6.4.052") < v_("6.4.053")
    assert v_("1ubuntu1") < v_("1ubuntu3.1")
    assert v_("1") < v_("1ubuntu1")
    assert v_("7.4.027") < v_("7.4.052")
  end
  # rubocop:enable Metrics/AbcSize

  # We take a sorted list of version numbers
  # as per libapt, shuffle it, then sort it as
  # per our implementation, and validate them as same
  def test_lst_sort
    shuffled = VERSIONS_FIXTURE.shuffle
    sorted_by_us = shuffled.sort_by { |v| v_(v) }
    # The ordering of equivalent versions is unspecified
    # in both the implementations, so we
    # do 2 checks:
    # 1. Simple version match. This matches 55k/56k of the versions
    # where the versions are different enough to be sorted correctly.
    # 2. In case, where the sort order was different, because both
    # versions are the same such as the following:

    # 0.0.5-1, 0.00.05-1
    # 0.00.05-1, 0.0.5-1
    # 0.00001-1, 0.01-1
    # 0.01-1, 0.00001-1
    # 0.01-1+b1, 0.1-1+b1

    # We break them down by parts, and validate that the parts are the same
    # If not, we raise an assertion error.
    VERSIONS_FIXTURE.zip(sorted_by_us).each do |apt, us|
      next unless apt != us.to_s

      # We check for part equivalence
      assert_equal v_(apt), v_(us.to_s)
      # and sort equivalence
      assert_equal v_(apt) <=> v_(us.to_s), 0
    end
  end
end
