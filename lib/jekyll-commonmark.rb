# frozen-string-literal: true

module Jekyll
  module Converters
    class Markdown
      class CommonMark
        def initialize(config)
          Jekyll::External.require_with_graceful_fail "commonmarker"
          begin
            options    = config["commonmark"]["options"].collect { |e| e.upcase.to_sym }
            valid_opts = Set.new(CommonMarker::Config::Parse.keys + CommonMarker::Config::Render.keys).to_a
            options    = validate(options, valid_opts, "option")
          rescue NoMethodError
            options = []
          end

          begin
            @extensions      = config["commonmark"]["extensions"].collect(&:to_sym)
            valid_extensions = CommonMarker.extensions.collect(&:to_sym)
            @extensions      = validate(@extensions, valid_extensions, "extension")
          rescue NoMethodError
            @extensions = []
          end

          options_set = Set.new(options).freeze
          @parse_options = (options_set & CommonMarker::Config::Parse.keys).to_a
          @render_options = (options_set & CommonMarker::Config::Render.keys).to_a

          @parse_options = :DEFAULT if @parse_options.empty?
          @render_options = :DEFAULT if @render_options.empty?
        end

        def convert(content)
          CommonMarker.render_doc(content, @parse_options, @extensions)
            .to_html(@render_options, @extensions)
        end

        private

        def validate(list, bucket, type)
          list.reject do |item|
            next if bucket.include?(item)

            Jekyll.logger.warn "CommonMark:", "#{item} is not a valid #{type}"
            Jekyll.logger.info "Valid #{type}s:", bucket.join(", ")
            true
          end
        end
      end
    end
  end
end
