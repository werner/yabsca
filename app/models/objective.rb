class Objective < ActiveRecord::Base
  belongs_to :perspective
  belongs_to :objective
  has_many :objectives
  
  has_and_belongs_to_many :measures
end
