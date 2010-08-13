class StrategyRule < ActiveRecord::Base
  belongs_to :strategy
  belongs_to :role

  validates_uniqueness_of :role_id, :scope => :strategy_id
end
