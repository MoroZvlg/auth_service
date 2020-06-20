class User < ApplicationModel
  include PasswordEncryptor
  one_to_many :user_sessions

  def validate
    super
    contract = UserContract.new
    result = contract.call(values)
    result.errors.to_h.each do |key, messages|
      messages.each do |message|
        errors.add(key, message)
      end
    end
  end

end