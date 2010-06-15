class Initiative < ActiveRecord::Base
  belongs_to :objective
  belongs_to :responsible
  belongs_to :initiative
  has_many :initiatives
end
