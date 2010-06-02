class Perspective < ActiveRecord::Base
  belongs_to :strategy
  has_many :objectives
  validates_presence_of :name

end
