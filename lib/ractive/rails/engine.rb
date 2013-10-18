module Ractive
  module Rails
    class Engine < ::Rails::Engine
      config.before_initialize do |app|
        Sprockets::Engines
        Sprockets.register_engine('.rac', Ractive)
        Sprockets.register_engine('.ractive', Ractive)
        Sprockets.register_engine('.ractive-haml', Ractive::Rails::Haml)
      end
    end
  end
end
