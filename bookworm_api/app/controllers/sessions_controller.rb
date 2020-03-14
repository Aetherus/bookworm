class SessionsController < ApplicationController
  skip_before_action :authenticate
  
  # POST /api/v1/session
  #
  # Params:
  #   email
  #   password
  #
  def create
    librarian = Librarian.find_by(email: params.require(:email))
                         .try(:authenticate, params.require(:password))

    if librarian
      render json: {librarian: librarian.as_json, access_token: AccessToken.generate(librarian.id)}
    else
      render json: {errors: {base: ['Invalid email address or password']}}, status: 403
    end
  end
end
