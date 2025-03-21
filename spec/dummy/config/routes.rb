Rails.application.routes.draw do
  root to: redirect(Avo.configuration.root_path)
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get "hey", to: "home#index"

  authenticate :user, ->(user) { user.is_admin? } do
    scope :admin do
      get "dashboard", to: "avo/tools#dashboard"
    end

    mount Avo::Engine, at: Avo.configuration.root_path
  end
end

if defined? ::Avo
  Avo::Engine.routes.draw do
    scope :resources do
      get "courses/cities", to: "courses#cities"
    end
  end
end
