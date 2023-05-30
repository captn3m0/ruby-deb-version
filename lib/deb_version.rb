# frozen_string_literal: true

require_relative "deb_version/version"
require_relative "deb_version/compare"

# Constants for the DebVersion class
class DebVersion
  class Error < StandardError; end
  # String of ASCII characters which are considered punctuation characters in the C locale:
  # Except for ~
  # Already sorted
  PUNCTUATION = "!\"\#$%&'()*+,-./:;<=>?@[]^_`{|}".chars
  DIGITS = ("0".."9").to_a

  # Sorted list of characters used by Debian Version sort.
  # see https://www.debian.org/doc/debian-policy/ch-controlfields.html#version
  SORT_LIST = ["~", ""] + ("A".."Z").to_a + ("a".."z").to_a + PUNCTUATION

  mapping = {}
  SORT_LIST.each_with_index do |char, index|
    mapping[char] = index
  end
  # Set it to a constant
  ORDER_MAPPING = mapping
end
