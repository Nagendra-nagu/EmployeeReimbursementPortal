Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :companies do
    resources :users do
      resources :reimbursement_claims
    end
  end
  root "application#root"
end
