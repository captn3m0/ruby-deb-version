# frozen_string_literal: true

require_relative "deb_version/version"
require_relative "deb_version/compare"

# Main Module for the gem
module DebVersion
  class Error < StandardError; end
  # String of ASCII characters which are considered punctuation characters in the C locale:
  # Except for ~
  # Already sorted
  PUNCTUATION = "!\"\#$%&'()*+,-./:;<=>?@[]^_`{|}".chars
  SORT_LIST = ["~", ""] + ("A"..."Z").to_a + ("a"..."z").to_a + PUNCTUATION

  mapping = {}
  SORT_LIST.each_with_index do |char, index|
    mapping[char] = index
  end
  ORDER_MAPPING = mapping

  DIGITS = ("0".."9").to_a
end
