class Objective < ActiveRecord::Base
  belongs_to :perspective
  has_many :objectives
  has_many :measures
end
