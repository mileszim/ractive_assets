module RactiveAssets
  class Engine < ::Rails::Engine
    initializer "sprockets.ractive", :after => "sprockets.environment", :group => :all do |app|
      next unless app.assets
      app.assets.register_engine '.rac',         TiltRactive
      app.assets.register_engine '.ractive',     TiltRactive
      app.assets.register_engine('.ractivehaml', TiltRactive) if RactiveAssets::Config.haml_available?
      app.assets.register_engine('.ractiveslim', TiltRactive) if RactiveAssets::Config.slim_available?
    end
  end
end
