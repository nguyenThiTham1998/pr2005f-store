Rails.application.routes.draw do

    scope "(:locale)", locale: /en|vi/ do
        resources :users
        resources :carts
        resources :orders
        resources :products
        resources  :order_details
        resources :add_products_to_carts
        resources :product_details   
        resources :comments 

        namespace :admin do
              get 'static_pages/home'
        end      

        # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
          as :user do

            get "signin" => "devise/sessions#new"
            post "signin" => "devise/sessions#create"
            delete "signout" => "devise/sessions#destroy"
        end
          

         resources :comments do
            resources :sub_comments 
           end 
        get '/admin/home', to: 'admin/static_pages#home'
        root 'pages#index'
        get '/home', to: 'pages#index'
        resources :products do 
          resources :product_details 
          resources :comments 
        end 

        get "/search", to: "searchs#index"
        get "admin/search", to: "admin/searchs#index"
        resources :comments 


        namespace :admin do
            get 'static_pages/home'
            resources :products do
              resources :product_details 
            end  
        resources :product_details                        
        resources :orders         
        resources :users     
        resources :comments     
        end
    end 
    devise_for :users,  
              controllers: {           
                sessions: 'users/sessions'           
              },            
              path: '', 
              path_names: {sign_in: 'login' ,sign_out: 'logout' ,edit: 'profile',sign_up: 'resgistration'},    
              controllers: {omniauth_callbacks: 'omniauth_callbacks' }  
end
