module RactiveAssets
  # Change config options in an initializer:
  #
  # Ractive::Config.path_prefix = 'app/templates'
  module Config
    extend self

    attr_writer :compiler, :compiler_path,
      :haml_options, :known_helpers, :known_helpers_only, :options,
      :patch_files, :patch_path, :path_prefix, :slim_options, :template_namespace

    def configure
      yield self
    end

    def compiler
      @compiler || 'ractive.js'
    end

    def compiler_path
      @compiler_path || RactiveAssets.path
    end

    def haml_available?
      defined? ::Haml::Engine
    end

    def haml_options
      @haml_options || {}
    end

    def options
      @options ||= generate_options
    end

    def path_prefix
      @path_prefix || 'templates'
    end

    def slim_available?
      defined? ::Slim::Engine
    end

    def slim_options
      @slim_options || {}
    end

    def template_namespace
      @template_namespace || 'RactiveTemplates'
    end

    private

    def generate_options
      options = @options || {}
      options
    end

  end
end
