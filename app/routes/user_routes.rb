class UserRoutes < Application

  namespace '/v1' do
    post '/sign_up' do
      user_params = validate_with!(PermitParams::NewUser)

      result = Users::CreateService.call(user_params: user_params.to_h)
      if result.success?
        status 201
        json succes: true
      else
        status 422
        error_response(result.user)
      end
    end

    post '/sign_in' do
      user_params = validate_with!(PermitParams::User)

      result = UserSessions::CreateService.call(user_params: user_params.to_h)

      if result.success?
        token = JwtEncoder.encode(uuid: result.session.uuid)

        status 201
        json meta: { token: token }
      else
        status 401
        error_response(result.session || result.errors)
      end
    end
  end
end
