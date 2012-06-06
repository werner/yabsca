Yabsca32::Application.routes.draw do
  resources :organizations
  resources :strategies
  resources :perspectives
  resources :objectives do
    member do
      get 'gantt'
    end
  end

  resources :measures do
    collection do
      get 'get_periods'
      get 'measure_charts'
    end
  end
    
  resources :initiatives
  resources :units
  resources :responsibles
  resources :targets
  resources :users

  match 'calculates_all' => 'targets#calculates_all'
  
  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
    get 'authorization'
  end

  root :to => 'home#index'

end
