class Strategy < ActiveRecord::Base
  belongs_to :organization
  has_many :strategies

  validates_presence_of :name

end
