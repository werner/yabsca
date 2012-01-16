class StandardController < ApplicationController
  attr_accessor :model
  def index
    records = @model.all

    respond_to do |format|
      format.json { render json: { data: records } }
    end
  end

  def show
    record = @model.find(params[:id])

    respond_to do |format|
      format.json { render json: { success: true, data: record } }
    end
  end

  def create
    record = @model.new(params[@model.to_s.downcase])

    respond_to do |format|
      if record.save
        format.json { render json: { success: true, data: record } }
      else
        format.json { render json: { success: false, data: record.errors } }
      end
    end
  end

  def update
    record = @model.find(params[:id])

    respond_to do |format|
      if record.update_attributes(params[@model.to_s.downcase])
        format.json { render json: { success: true, data: record } }
      else
        format.json { render json: { success: false, data: record.errors } }
      end
    end
  end

  def destroy
    record = @model.find(params[:id])
    record.destroy

    respond_to do |format|
      format.json { render json: { success: true } }
    end
  end
end
