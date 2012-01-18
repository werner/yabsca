class PerspectivesController < ApplicationController
  def initialize
    @model = Perspective
  end

  def index
    perspectives = Perspective.tree params[:node]
    objectives = Objective.tree params[:node]
    result = perspectives + objectives

    respond_to do |format|
      format.json { render json: {data: result}}
    end
  end

end
