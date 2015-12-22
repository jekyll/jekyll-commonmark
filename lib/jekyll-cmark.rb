# Frozen-string-literal: true
# Encoding: utf-8

module Jekyll
  module Converters
    class Markdown::CMark
      def initialize(config)
        @config = config
      end

      def convert(content)
        require 'commonmarker'
        CommonMarker.render_html(content, [:smart, :normalize])
      end
    end
  end
end
