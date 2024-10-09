Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      get "/",  to: "location#get_location"
      post "/", to: "location#save_location"
      delete "/", to: "location#delete_location"
    end
  end
end
