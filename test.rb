# frozen_string_literal: true

require "minitest/autorun"
require "deb_version"

class DebianVersionTest < Minitest::Test
  def to_a(version)
    v_(version).to_a
  end

  def v_(version)
    DebVersion::DebianVersion.new(version)
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
    File.readlines("all-debian-versions.lst").each do |version|
      v_(version)
    end
  end

  def test_equality
    assert v_("1") == v_("1")
    assert v_("1.0") == v_("1.0")
    assert v_("2:1.0") == v_("2:1.0")
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
  end
end
