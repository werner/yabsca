ActionController::Routing::Routes.draw do |map|

  map.resources :organizations, :strategies, :perspectives, :responsibles,
                  :objectives, :units, :measures, :targets, :initiatives

  map.generate_gantt '/generate_gantt', :controller => 'presentation', :action => 'generate_gantt'
  map.generate_chart '/generate_chart', :controller => 'presentation', :action => 'generate_chart'
  map.chart '/chart', :controller => 'presentation', :action => 'chart'
  map.get_targets '/get_targets', :controller => 'presentation', :action => 'get_targets'
  map.org_and_strat '/org_and_strat',:controller => 'presentation', :action => 'org_and_strat'
  map.persp_and_objs '/persp_and_objs', :controller => 'presentation', :action => 'persp_and_objs'
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
