module AccessToken
  @secret = Rails.application.credentials.secret_key_base

  def self.generate(subject)
    JWT.encode({sub: subject, exp: 1.day.from_now.to_i}, @secret, 'HS256')
  end

  def self.verify(token)
    JWT.decode(token, @secret, true, algorithm: 'HS256')[0]['sub'] rescue nil
  end
end
