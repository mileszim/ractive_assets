require 'tilt/template'
require 'haml'

module Ractive
  module Rails
    class Haml < Tilt::Template
      self.default_mime_type = 'application/javascript'

      def prepare
        options = @options.merge(:filename => eval_file, :line => line)
        clean_shaven = data.gsub(/\{\{(.*)\}\}/) do |m|
            "_MUSTACHIO_START_"+ Base64.strict_encode64(m)+"_MUSTACHIO_END_"
          end
        @engine = ::Haml::Engine.new(clean_shaven, options)
      end

      def evaluate(scope, locals, &block)
        clean_shaven = @engine.render(scope, locals, &block)

        data = clean_shaven.gsub(/_MUSTACHIO_START_(.*)_MUSTACHIO_END_/) do |m,a|
          Base64.strict_decode64(m[17...-15])
        end
      end
    end
  end
end
