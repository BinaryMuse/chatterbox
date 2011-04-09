Chatterbox::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :rooms do
    get  :join,   :on => :collection
    post :search, :on => :collection
    post :unlock, :on => :member
    post :chat,   :on => :member
    post :leave,  :on => :member
  end
  root :to => "rooms#index"
end
