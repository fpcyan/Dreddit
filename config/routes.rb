Rails.application.routes.draw do

  resources :users, only: [:show, :new, :create] do
    resources :subs, only: [:new]
  end

  resource :session, only: [:new, :create, :destroy]
  resources :subs, except: [:destroy, :new]

end
