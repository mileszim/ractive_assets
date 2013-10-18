require 'tilt/template'
require 'haml'

module Ractive
  module Rails
    class Haml < Tilt::Template
      self.metadata[:mime_type] = 'application/javascript'

      def prepare
        options = @options.merge(:filename => eval_file, :line => line)
        @engine = ::Haml::Engine.new(data, options)
      end

      def evaluate(scope, locals, &block)
        @data = @engine.render(scope, locals, &block)
      end
    end
  end
end
