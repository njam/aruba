require 'fileutils'

# @!method have_same_file_content_like(file_name)
#   This matchers checks if <file1> has the same content like <file2>
#
#   @param [String] file_name
#     The name of the file which should be compared with the file in the
#     `expect()`-call.
#
#   @return [TrueClass, FalseClass] The result
#
#     false:
#     * if file1 is not equal file2
#     true:
#     * if file1 is equal file2
#
#   @example Use matcher
#
#     RSpec.describe do
#       it { expect(file1).to have_same_file_content_like(file2) }
#     end
RSpec::Matchers.define :have_same_file_content_like do |expected|
  stop_processes!

  match do |actual|
    FileUtils.compare_file(
      expand_path(actual),
      expand_path(expected)
    )
  end

  failure_message do |actual|
    format("expected that file \"%s\" is the same as file \"%s\".", actual, expected)
  end

  failure_message_when_negated do |actual|
    format("expected that file \"%s\" differs from file \"%s\".", actual, expected)
  end
end

