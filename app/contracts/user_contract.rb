class UserContract < Dry::Validation::Contract
  params do
    required(:email).value(:string)
    required(:name).value(:string)
    required(:password).value(:string)
  end

  rule(:email) do
    unless /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.match?(value)
      key.failure(I18n.t(:wrong_email_format, scope: 'contracts'))
    end
  end

  rule(:name) do
    unless /\A\w+\z/i.match?(value)
      key.failure(I18n.t(:wrong_name_format, scope: 'contracts'))
    end
  end

end