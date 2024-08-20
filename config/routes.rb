Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root "application#root"

  resources :companies do
    resources :users do
      resources :reimbursement_claims
    end
  end
end
