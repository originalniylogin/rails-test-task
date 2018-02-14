Rails.application.routes.draw do

  get 'welcome/index'

  root 'welcome#index'

  resources :event_handlers

  resources :events

end
