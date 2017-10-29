Rails.application.routes.draw do
  namespace :site, path: '' do
    resource :about, only: :show do
      get :ping
    end
  end

  root to: 'site/abouts#show'
end
