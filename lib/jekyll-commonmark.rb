# frozen-string-literal: true

Jekyll::External.require_with_graceful_fail "commonmarker"
require_relative "jekyll-commonmark/html_renderer"

module Jekyll
  module Converters
    class Markdown
      class CommonMark
        DEFAULT_CONFIG = { "extensions" => [], "options" => [] }.freeze
        PARSE_KEYS = CommonMarker::Config::Parse.keys
        RENDER_KEYS = CommonMarker::Config::Render.keys
        VALID_EXTENSIONS = CommonMarker.extensions.collect(&:to_sym)
        VALID_OPTIONS = (PARSE_KEYS + RENDER_KEYS).uniq

        private_constant :DEFAULT_CONFIG, :PARSE_KEYS, :RENDER_KEYS,
                         :VALID_EXTENSIONS, :VALID_OPTIONS

        def initialize(config)
          @config = config["commonmark"] || DEFAULT_CONFIG

          @parse_options = options & PARSE_KEYS
          @render_options = options & RENDER_KEYS

          @parse_options = :DEFAULT if @parse_options.empty?
          @render_options = :DEFAULT if @render_options.empty?
        end

        def convert(content)
          HtmlRenderer.new(
            :options    => render_options,
            :extensions => extensions
          ).render(
            CommonMarker.render_doc(content, parse_options, extensions)
          )
        end

        private

        attr_reader :config, :parse_options, :render_options

        def extensions
          @extensions ||= prepare("extensions", ->(item) { item.to_sym }, VALID_EXTENSIONS)
        end

        def options
          @options ||= prepare("options", ->(item) { item.upcase.to_sym }, VALID_OPTIONS)
        end

        def prepare(key, proc, valid_keys)
          collection = config[key].map(&proc)
          validate(collection, valid_keys, key[0..-2])
        end

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
