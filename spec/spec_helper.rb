# frozen_string_literal: true

require "jekyll"
require_relative "../lib/jekyll-commonmark.rb"

Jekyll.logger.log_level = :info

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = "random"

  def capture_stdout(level = :debug)
    buffer = StringIO.new
    Jekyll.logger = Logger.new(buffer)
    Jekyll.logger.log_level = level
    result = yield
    buffer.rewind
    [result, buffer.string.to_s]
  ensure
    Jekyll.logger = Logger.new(StringIO.new, :error)
  end
end
