ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'shrine/storage/memory'
require "image_processing/mini_magick"

Shrine.storages = {
  cache: Shrine::Storage::Memory.new,
  store: Shrine::Storage::Memory.new,
}

class ActiveSupport::TestCase
  fixtures :all
  def is_logged_in?
    !session[:user_id].nil?
  end

  def login_as(user)
    session[:user_id] = user.id
  end

  setup do
    image = File.open("test/fixtures/files/tapir.jpg")
    Shrine.storages[:store].upload(image, "tapir.jpg")
  end
end

class ActionDispatch::IntegrationTest #Integration Test用
  def login_as(user)
    post login_path, params: { user: { email: user.email,
                                          password: "password",
                                          } }
  end

  def update(user,name:user.name, account:user.account, email:user.email)
    
  end
end
