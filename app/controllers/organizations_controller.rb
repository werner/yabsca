class OrganizationsController < ApplicationController

  def edit
    @organization=Organization.find(params[:id])

    return_data={}
    return_data[:success]=true
    return_data[:data]={"organization[name]" => @organization.name,
                        "organization[vision]" => @organization.vision,
                        "organization[goal]" => @organization.goal,
                        "organization[organization_id]" => @organization.organization_id}

    respond_to do |format|
      format.json { render :json => return_data }
    end
  end

  def create
    self.default_creation(Organization, params[:organization])
  end

  def update
    self.default_updating(Organization, params[:id], params[:organization])
  end

  def destroy
    self.default_destroy(Organization, params[:id])
  end
end
