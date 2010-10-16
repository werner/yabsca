require 'test_helper'

class MeasureTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end

  test 'name_presence' do
    measure = Measure.new
    assert !measure.valid?
    assert measure.errors.invalid?(:name)
  end

  test 'get_periods' do
    measure = Measure.new(:name=>"ABC",:period_from=>'01/01/2010',
                          :period_to=>'12/31/2010',:frecuency=>Frecuency::Monthly)
    assert measure.get_periods
  end

end
