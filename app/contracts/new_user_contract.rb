class NewUserContract < Dry::Validation::Contract
  params do
    required(:email).filled(:string)
    required(:name).filled(:string)
    required(:password).filled(:string)
    required(:password_confirmation).filled(:string)
  end

  rule(:email) do
    unless /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.match?(value)
      key.failure(I18n.t(:wrong_email_format, scope: 'contracts'))
    end
  end

  rule(:password, :password_confirmation) do
    key.failure(I18n.t(:passwords_not_match, scope: 'contracts')) if values[:password_confirmation] != values[:password]
  end

end