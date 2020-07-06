module Auth
  class FetchUserService
    prepend ApplicationService

    param :uuid

    attr_reader :user

    def call
      if @uuid.blank? || !valid_uuid? || session.blank?
        fail!(I18n.t(:forbidden, scope: 'services.auth.fetch_user_service'))
      else
        @user = session.user
      end
    end

    private

    def valid_uuid?
      uuid_regex = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/
      uuid_regex.match?(@uuid.to_s.downcase)
    end

    def session
      @session ||= UserSession.find(uuid: @uuid)
    end
  end
end
