class Strategy < ActiveRecord::Base
  belongs_to :organization
  has_many :perspectives
  validates_presence_of :name

end
