# frozen-string-literal: true

module Jekyll
  module Converters
    class Markdown::CommonMark
      def initialize(config)
        Jekyll::External.require_with_graceful_fail "commonmarker"
        begin
          @options = config["commonmark"]["options"].collect { |e| e.upcase.to_sym }
        rescue NoMethodError
          @options = []
        else
          valid_opts = Set.new(CommonMarker::Config::Parse.keys + CommonMarker::Config::Render.keys)
          @options.reject! do |e|
            next if valid_opts.include? e
            Jekyll.logger.warn "CommonMark:", "#{e} is not a valid option"
            Jekyll.logger.info "Valid options:", valid_opts.to_a.join(", ")
            true
          end
        end
        begin
          @extensions = config["commonmark"]["extensions"].collect(&:to_sym)
        rescue NoMethodError
          @extensions = []
        else
          @extensions.reject! do |e|
            next if CommonMarker.extensions.include? e.to_s
            Jekyll.logger.warn "CommonMark:", "#{e} is not a valid extension"
            Jekyll.logger.info "Valid extensions:", CommonMarker.extensions.join(", ")
            true
          end
        end
      end

      def convert(content)
        parse_options = (Set.new(@options) & CommonMarker::Config::Parse.keys).to_a
        render_options = (Set.new(@options) & CommonMarker::Config::Render.keys).to_a
        parse_options = :DEFAULT if parse_options.empty?
        render_options = :DEFAULT if render_options.empty?
        CommonMarker.render_doc(content, parse_options, @extensions).to_html(render_options, @extensions)
      end
    end
  end
end
