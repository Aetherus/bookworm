Rails.application.routes.draw do
  scope '/api/v1' do
    resources :sessions, only: [:create]

    resources :accounts, only: [:create, :show]

    resources :books, except: [:destroy]

    resources :loans, only: [:create] do
      delete :conclude, on: :member
    end

    get '/books/:book_id/loans' => 'loans#index'
  end
end
