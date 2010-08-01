class StrategiesController < ApplicationController
  before_filter :require_user
  
  def index
    
    session[:strategy_id]=params[:id] unless params[:id].nil?

    strategy=Strategy.find(session[:strategy_id])

    return_data=[]
    if params[:node].match(/src:root/)
      return_data.push({
          :id => "src:strats"+strategy.id.to_s,
          :iddb => strategy.id,
          :text => strategy.name,
          :iconCls => "strats",
          :type => "strategy",
          :leaf => strategy.perspectives.empty?
        })
    else
      return_data=nodes_selection(params[:node])
    end unless params[:node].nil?

    respond_to do |format|
      format.html
      format.json { render :json => return_data }
    end
  end
  
  def edit
    @strategy=Strategy.find(params[:id])

    return_data={}
    return_data[:success]=true
    return_data[:data]={"strategy[name]"=>@strategy.name,
                        "strategy[description]"=>@strategy.description,
                        "strategy[organization_id]"=>@strategy.organization_id,
                        "strategy[strategy_map]"=>@strategy.strategy_map}

    respond_to do |format|
      format.json { render :json => return_data }
    end
  end

  def export
    strategy=Strategy.find(params[:id])
    temp_file=Tempfile.new(["image",".svg"], "#{Rails.root}/tmp")
    temp_file.puts strategy.strategy_map_svg
    temp_file.close
    send_file temp_file.path, :stream => true
  end

  def create
    self.default_creation(Strategy, params[:strategy])
  end

  def update
    self.default_updating(Strategy, params[:id], params[:strategy])
  end

  def destroy
    self.default_destroy(Strategy, params[:id])
  end
end
