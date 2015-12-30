# Frozen-string-literal: true
# Encoding: utf-8

module Jekyll
  module Converters
    class Markdown::CommonMark
      def initialize(config)
        Jekyll::External.require_with_graceful_fail "commonmarker"
        begin
          @options = config['commonmark']['options'].collect { |e|
            if CommonMarker::Config::Parse.keys.include? e.to_sym
              e.to_sym
            else
              Jekyll.logger.warn "CommonMark:", "#{e} is not a valid option"
              Jekyll.logger.info "Valid options:", CommonMarker::Config::Parse.keys.join(", ")
              nil
            end
          }
          @options.compact!
        rescue NoMethodError
          @options = [:default]
        end
      end

      def convert(content)
        CommonMarker.render_doc(content, @options).to_html
      end
    end
  end
end
