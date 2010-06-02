ActionController::Routing::Routes.draw do |map|

  map.resources :organizations, :strategies, :perspectives

  map.org_and_strat '/org_and_strat',:controller => 'presentation', :action => 'org_and_strat'
  map.persp_and_objs '/persp_and_objs', :controller => 'presentation', :action => 'persp_and_objs'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
