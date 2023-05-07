# frozen_string_literal: true

module DebVersion
  class DebianVersion
    attr_reader :epoch, :upstream_version, :debian_revision

    include Comparable

    def initialize(version)
      @version = version
      @epoch = 0
      @debian_revision = ""

      if @version.include? ":"
        @epoch, @version = @version.split(":")
        @epoch = @epoch.to_i
      end

      if @version.include? "-"
        @upstream_version, _, @debian_revision = @version.rpartition("-")
      else
        @upstream_version = @version
      end
    end

    def to_a
      [@epoch, @upstream_version, @debian_revision]
    end

    def get_digit_prefix(characters)
      value = 0
      value = (value * 10) + characters.shift.to_i while characters && DebVersion::DIGITS.include?(characters[0])
      value
    end

    def get_non_digit_prefix(characters)
      prefix = []
      prefix << characters.shift while characters.size.positive? && !DebVersion::DIGITS.include?(characters[0])
      prefix
    end

    def compare_strings(version1, version2)
      v1 = version1.chars
      v2 = version2.chars
      while !v1.empty? || !v2.empty?
        p1 = get_non_digit_prefix(v1)
        p2 = get_non_digit_prefix(v2)
        if p1 != p2
          loop do
            c1 = p1.shift
            c2 = p2.shift
            break if c1.nil? && c2.nil?

            o1 = DebVersion::ORDER_MAPPING.fetch(c1 || "")
            o2 = DebVersion::ORDER_MAPPING.fetch(c2 || "")
            if o1 < o2
              return -1
            elsif o1 > o2
              return 1
            end
          end
        end
        d1 = get_digit_prefix(v1)
        d2 = get_digit_prefix(v2)
        if d1 < d2
          return -1
        elsif d1 > d2
          return 1
        end
      end
      0
    end

    def <=>(other)
      return epoch <=> other.epoch if epoch != other.epoch

      result = compare_strings(upstream_version, other.upstream_version)

      return result if result != 0

      return compare_strings(debian_revision, other.debian_revision) if debian_revision || other.debian_revision

      0
    end
  end
end
