class Objective < ActiveRecord::Base
  belongs_to :perspective
  has_many :objectives
end
