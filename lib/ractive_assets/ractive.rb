# Based on https://github.com/josh/ruby-coffee-script, https://github.com/leshill/handlebars_assets
require 'execjs'
require 'pathname'

module RactiveAssets
  class Ractive
    class << self

      def precompile(*args)
        context.call('Ractive.parse', *args)
      end

      protected

      attr_writer :source

      def context
        @context ||= ExecJS.compile(source)
      end

      def source
        @source ||= path.read
      end

      def path
        @path ||= assets_path.join(RactiveAssets::Config.compiler)
      end

      def assets_path
        @assets_path ||= Pathname(RactiveAssets::Config.compiler_path)
      end
    end
  end
end
