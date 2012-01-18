class OrganizationsController < StandardController
  def initialize
    @model = Organization
  end

  def index
    organizations = Organization.tree params[:node]
    strategies = Strategy.tree params[:node]
    result = organizations + strategies

    respond_to do |format|
      format.json { render json: { data: result } }
    end
  end
end
