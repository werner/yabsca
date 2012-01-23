class Responsible < ActiveRecord::Base
  has_many  :measures
  has_many  :initiatives
end
