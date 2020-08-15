# frozen_string_literal: true

require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_mailbox/engine'
require 'action_text/engine'
require 'action_view/railtie'
require 'action_cable/engine'
require 'sprockets/railtie'
# require "rails/test_unit/railtie"

Bundler.require(*Rails.groups)

module SbknBlog
  class Application < Rails::Application
    config.load_defaults 6.0
    config.generators.system_tests = nil

    # 日本語化対応
    config.i18n.default_locale = :ja
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
    Dir[Rails.root.join('lib/monkey_patches/**/*.rb')].sort.each do |file|
      require file
    end

    config.hosts << "ec2-54-92-117-212.ap-northeast-1.compute.amazonaws.com"
    config.hosts << "ec2-54-95-29-224.ap-northeast-1.compute.amazonaws.com"
  end
end
