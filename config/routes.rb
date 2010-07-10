ActionController::Routing::Routes.draw do |map|

  map.resources :organizations, :strategies, :perspectives, :responsibles, :roles,
                  :objectives, :units, :measures, :targets, :initiatives, :user_sessions, :users

  map.save_target '/save_target', :controller => 'targets', :action => 'save_target'
  map.get_all_targets '/get_all_targets', :controller => 'measures', :action => 'get_all_targets'
  map.check_formula '/check_formula', :controller => 'measures', :action => 'check_formula'
  map.get_formula '/get_formula', :controller => 'measures', :action => 'get_formula'
  map.join_nodes_all_measures '/all_measures', :controller => 'measures', :action => 'all_measures'
  map.generate_gantt '/generate_gantt', :controller => 'presentation', :action => 'generate_gantt'
  map.generate_chart '/generate_chart', :controller => 'presentation', :action => 'generate_chart'
  map.chart '/chart', :controller => 'presentation', :action => 'chart'
  map.get_targets '/get_targets', :controller => 'presentation', :action => 'get_targets'
  map.org_and_strat '/org_and_strat',:controller => 'presentation', :action => 'org_and_strat'
  map.persp_and_objs '/persp_and_objs', :controller => 'presentation', :action => 'persp_and_objs'
  map.everything '/everything', :controller => 'admin', :action => 'everything'
  map.roles_privileges '/roles_privileges', :controller => 'admin', :action => 'roles_privileges'
  map.create_priv '/create_priv', :controller => 'roles', :action => 'create_priv'

  map.destroy '/destroy', :controller => 'user_sessions', :action => 'destroy'
  
  map.root :controller => "user_sessions", :action  => "new"

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
