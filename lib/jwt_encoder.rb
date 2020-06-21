module JwtEncoder
  extend self

  HMAC_SECRET = Settings.application.jwt_secure_code

  def encode(payload)
    JWT.encode(payload, HMAC_SECRET)
  end

  def decode(token)
    JWT.decode(token, HMAC_SECRET).first
  end
end