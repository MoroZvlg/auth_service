
module PasswordEncryptor
  class WrongPasswordError < StandardError; end

  def self.included(base)
    base.include InstanceMethods
  end

  module InstanceMethods
    require "bcrypt"

    def password=(unencrypted)
      @password = unencrypted

      self.password_digest = BCrypt::Password.create(unencrypted)
    end

    def password
      @password ||= BCrypt::Password.new(self.password_digest)
    end

    def authenticate(unencrypted)
      if password == unencrypted
        self
      end
    end

    def authenticate!(unencrypted)
      authenticate(unencrypted) || raise_wrong_password
    end

    def raise_wrong_password
      raise WrongPasswordError
    end
  end
end