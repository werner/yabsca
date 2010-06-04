class UnitsController < ApplicationController

  def index
    @units=Unit.all

    return_data={}
    return_data[:data]=@units.collect{|u|{
        :id => u.id, :name => u.name
      }}

    respond_to do |format|
      format.json { render :json => return_data }
    end
  end

  def new
    @unit=Unit.new
  end

  def edit
    @unit=Unit.find(params[:id])

    return_data={}
    return_data[:success]=true
    return_data[:data]={"unit[name]" => @unit.name}

    respond_to do |format|
      format.json { render :json => return_data }
    end
  end

  def create
    self.default_creation(Unit, params[:unit])
  end

  def update
    self.default_updating(Unit, params[:id], params[:unit])
  end

  def destroy
    self.default_destroy(Unit, params[:id])
  end
end
