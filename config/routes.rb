Rails.application.routes.draw do
  get 'home/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
   
  # For more details on this file's DSL, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
end
