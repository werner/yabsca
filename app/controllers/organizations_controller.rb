class OrganizationsController < ApplicationController
  def index
    @organizations = Organization.tree params[:node]

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: { data: @organizations } }
    end
  end

  def show
    @organization = Organization.find(params[:id])

    respond_to do |format|
      format.json { render json: { success: true, data: @organization } }
    end
  end

  def create
    @organization = Organization.new(params[:organization])

    respond_to do |format|
      if @organization.save
        format.json { render json: { success: true, data: @organization } }
      else
        format.json { render json: { success: false, data: @organization.errors } }
      end
    end
  end

  def update
    @organization = Organization.find(params[:id])

    respond_to do |format|
      if @organization.update_attributes(params[:organization])
        format.json { render json: { success: true, data: @organization } }
      else
        format.json { render json: { success: false, data: @organization.errors } }
      end
    end
  end

  def destroy
    @organization = Organization.find(params[:id])
    @organization.destroy

    respond_to do |format|
      format.json { render json: { success: true } }
    end
  end
end
