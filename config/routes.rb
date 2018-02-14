Rails.application.routes.draw do

  root 'welcome#index'
  get 'welcome/index'
  resources :event_handlers
  resources :events

  namespace :admin do
    get    '/login',  to: 'sessions#new'
    post   '/login',  to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'
    resources :event_handlers
    resources :events
  end

end
