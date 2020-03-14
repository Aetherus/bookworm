class ApplicationController < ActionController::API
  before_action :authenticate

  private

  def current_librarian
    return @current_librarian if @current_librarian
    access_token = request.headers['Authorization'].to_s.split(' ', 2)[1]
    librarian_id = AccessToken.verify(access_token)
    @current_librarian = librarian_id && Librarian.find_by(id: librarian_id)
  end

  def authenticate
    render json: {errors: {base: ['Permission denied']}}, status: 401 unless current_librarian
  end
end
