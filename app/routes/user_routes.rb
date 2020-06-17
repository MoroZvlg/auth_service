class UserRoutes < Application

  namespace '/v1' do
    post '/sign_up' do
      user_params = validate_with(NewUserContract)
      if user_params.failure?
        status 422
        error_response(user_params.errors.to_h)
      else
        result = Users::CreateService.call(user_params: user_params.to_h)
        if result.success?
          status 201
          json succes: true
        else
          status 422
          error_response(result.user)
        end
      end

    end

    post '/sign_in' do
      user_params = validate_with(SignInContract)
      if user_params.failure?
        status 422
        error_response(user_params.errors.to_h)
      else
        result = UserSessions::CreateService.call(user_params: user_params.to_h)

        if result.success?
          status 201
          json succes: true
        else
          status 422
          error_response(result.session || result.errors)
        end
      end
    end
  end
end
