Rails.application.routes.draw do
  root 'welcome#index'
  get 'welcome/index'
  get '/events', to: 'events#index', as: :events
  get '/events/:id', to: 'events#show', as: :event
  get '/events/:id/ics', to: 'events#download_ics', as: :event_ics
  get '/event_handlers', to: 'event_handlers#index', as: :event_handlers
  get '/event_handlers/:id', to: 'event_handlers#show', as: :event_handler
  get '/subscribe', to: 'subscribers#new', as: :new_subscriber
  post '/subscribe', to: 'subscribers#create'

  namespace :admin do
    get    '/login',  to: 'sessions#new'
    post   '/login',  to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'
    resources :event_handlers
    resources :events
    get '/event/:id/email_subscribers', to: 'events#email_subscribers', as: :email_subs
  end
end
