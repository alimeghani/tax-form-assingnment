Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      get 'users' => 'users#index'

      get 'forms' => 'forms#index'

      post 'forms/:form_id/submit' => 'forms#submit_form'

      post 'forms/:form_id/generate' => 'forms#generate_form'
    end
  end

end
