module Flexite
  class Engine < ::Rails::Engine
    isolate_namespace Flexite

    config.before_configuration do |app|
      app.config.assets.precompile << /\.(?:svg|eot|woff|ttf)\z/
      app.config.assets.paths << File.join(root, 'app', 'assets', 'fonts')
    end

    initializer 'flexite.append_migrations' do |app|
      paths['db/migrate'].expanded.each do |migration|
        app.paths['db/migrate'] << migration
      end
    end

    config.action_controller.include_all_helpers = false
    config.paths.add 'app/models/concerns', eager_load: true
  end
end
