class Perspective < ActiveRecord::Base
  belongs_to :strategy
  validates_presence_of :name

end
