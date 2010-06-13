class Initiative < ActiveRecord::Base
  belongs_to :objective
  belongs_to :initiative
  has_many :initiatives
end
