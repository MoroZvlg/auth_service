module UserSessions
  class CreateService
    prepend ApplicationService

    option :user_params do
      option :email
      option :password
    end
    option :user, default: proc { User.find(email: @user_params.email) }, reader: false

    attr_reader :session

    def call
      validate
      create_session unless failure?
    end

    private

    def validate
      return fail_t!(:unauthorized) unless @user&.authenticate(@user_params.password)
    end

    def create_session
      @session = UserSession.new(user: @user)
      if session.valid?
        @session.save
      else
        fail!(@session.errors)
      end
    end

    def fail_t!(key)
      fail!(I18n.t(key, scope: 'services.user_sessions.create_service'))
    end
  end
end