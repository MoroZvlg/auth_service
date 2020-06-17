class User < ApplicationModel
  include PasswordEncryptor

  one_to_many :user_sessions
end