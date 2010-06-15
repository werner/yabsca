class ResponsiblesController < ApplicationController
  def index
    @responsibles=Responsible.all

    return_data={}
    return_data[:data]=@responsibles.collect{|u|{
        :id => u.id, :name => u.name
      }}

    respond_to do |format|
      format.json { render :json => return_data }
    end
  end

  def create
    self.default_creation(Responsible, params[:responsible])
  end

  def update
    self.default_updating(Responsible, params[:id], params[:responsible])
  end

  def destroy
    self.default_destroy(Responsible, params[:id])
  end
end
