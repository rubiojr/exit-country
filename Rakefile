# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/osx'
require 'bubble-wrap'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'Exit Country'
  app.info_plist['LSUIElement'] = true
  app.deployment_target = '10.10'
  # Images will not load from the flags directory otherwise
  app.resources_dirs << ['resources/flags_iso/16']
end
