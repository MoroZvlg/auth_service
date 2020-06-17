class NewUserContract < Dry::Validation::Contract
  params do
    required(:email).filled(:string)
    required(:name).filled(:string)
    required(:password).filled(:string)
    required(:password_confirmation).filled(:string)
  end

  rule(:email) do
    unless /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.match?(value)
      key.failure('has invalid format')
    end
  end

  rule(:password, :password_confirmation) do
    key.failure('Passwords not match') if values[:password_confirmation] != values[:password]
  end

end