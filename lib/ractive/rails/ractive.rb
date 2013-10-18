require 'tilt'
module Ractive
  module Rails
    class Ractive < Tilt::Template
      include ActionView::Helpers::JavaScriptHelper
      self.default_mime_type = 'application/javascript'

      def prepare; end

      def context
        if @context
          @context
        else
          assets_path = Pathname(__FILE__).dirname.join('..', '..', '..', 'vendor', 'assets')
          ractive_source = assets_path.join('javascripts', 'ractive.js')

          @context = ExecJS.compile(ractive_source.read)
        end
      end

      def evaluate(scope, locals, &block)
        compiled_template = context.eval("Ractive.parse(\"#{escape_javascript(@data)}\")")
        <<-TEMPLATE
          this.RactiveTemplates || (this.RactiveTemplates = {});
          this.RactiveTemplates['#{scope.logical_path}'] = #{compiled_template.to_json};
        TEMPLATE
      end
    end
  end
end
