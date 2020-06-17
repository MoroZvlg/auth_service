module Users
  class CreateService
    prepend ApplicationService

    option :user_params do
      option :name
      option :email
      option :password
    end

    attr_reader :user

    def call
      @user = User.new(@user_params.to_h)

      if @user.valid?
        user.save
      else
        fail!(@user.errors)
      end
    end
  end
end