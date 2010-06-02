class Organization < ActiveRecord::Base
  has_many :strategies
  belongs_to :organization
  has_many :organizations

  validates_presence_of :name
end
