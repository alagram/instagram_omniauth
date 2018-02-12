Rails.application.routes.draw do
  get 'activity/mine'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'activity#mine'
end
