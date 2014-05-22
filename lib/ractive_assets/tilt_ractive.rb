require 'tilt'
require 'multi_json'

module RactiveAssets

  module Unindent
    # http://bit.ly/aze9FV
    # Strip leading whitespace from each line that is the same as the
    # amount of whitespace on the first line of the string.
    # Leaves _additional_ indentation on later lines intact.
    def unindent(heredoc)
      heredoc.gsub /^#{heredoc[/\A\s*/]}/, ''
    end
  end
  
  class TiltRactive < Tilt::Template

    include Unindent

    def self.default_mime_type
      'application/javascript'
    end

    def evaluate(scope, locals, &block)
      template_path = TemplatePath.new(scope)

      source = if template_path.is_haml?
        Haml::Engine.new(data, RactiveAssets::Config.haml_options).render(scope, locals)
      elsif template_path.is_slim?
        Slim::Template.new(RactiveAssets::Config.slim_options) { data }.render(scope, locals)
      else
        data
      end

      compile(source, template_path)
    end

    def initialize_engine
      begin
        require 'haml'
      rescue LoadError
        # haml not available
      end
      begin
        require 'slim'
      rescue LoadError
        # slim not available
      end
    end

    def compile(source, template_path)
      compiled_rac = Ractive.precompile(source, RactiveAssets::Config.options)
      template_namespace = RactiveAssets::Config.template_namespace

      unindent <<-TEMPLATE
        (function() {
          this.#{template_namespace} || (this.#{template_namespace} = {});
          this.#{template_namespace}[#{template_path.name}] = #{compiled_rac.to_json};
          return this.#{template_namespace}[#{template_path.name}];
        }).call(this);
      TEMPLATE
    end

    protected

    def prepare; end

    class TemplatePath
      def initialize(scope)
        self.full_path = scope.pathname
        self.template_path = scope.logical_path
      end

      def is_haml?
        full_path.to_s.end_with?('.ractivehaml')
      end

      def is_slim?
        full_path.to_s.end_with?('.ractiveslim')
      end

      def name
        template_name
      end

      private

      attr_accessor :full_path, :template_path

      def relative_path
        template_path.gsub(/^#{RactiveAssets::Config.path_prefix}\/(.*)$/i, "\\1")
      end

      def template_name
        relative_path.dump
      end
    end

  end
end
