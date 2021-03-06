module Auth
  extend ActiveSupport::Concern

  AUTH_TOKEN = %r{\ABearer (?<token>.+)\z}

  private

  def extracted_token
    JwtEncoder.decode(matched_token)
  rescue JWT::DecodeError
    {}
  end

  def matched_token
    result = auth_header&.match(AUTH_TOKEN)
    return if result.blank?

    result[:token]
  end

  def auth_header
    request.env["HTTP_AUTHORIZATION"]
  end
end
