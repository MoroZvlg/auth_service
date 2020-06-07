pp ENV['RACK_ENV']
Sequel.seed(:development) do
  def run
    pp 'run SEED'
    user = User.create(name: 'test_user', email: 'test_email@example.com', password: 'qwerty123')
    pp "NEW USER #{user}"
  end
end
