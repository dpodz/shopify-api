Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :products, only: [:index, :show] do
    # nothing
  end
  post 'products/:id/purchase', to: 'products#purchase' do
    # nothing
  end
end
