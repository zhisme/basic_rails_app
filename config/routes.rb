Rails.application.routes.draw do
  namespace :site, path: '' do
    resource :about, only: :show do
      get :ping
    end
  end

  # Prefer use redirect_fallback_path instead of root_path
  # for default redirect locations, as it's much easier to change it if required.
  get '/', to: 'site/abouts#show', as: :redirect_fallback

  root to: 'site/abouts#show'
end
