Sequel.seed(:development) do
  def run
    user = User.create(name: 'test_user', email: 'test_email@example.com', password: 'qwerty123')
  end
end
