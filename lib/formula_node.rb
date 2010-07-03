module FormulaNode
  attr_accessor :period
  def code_value
    text_value.gsub(/<c>[a-zA-Z0-9\-\_\.]*<\/c>/) { |i|
      i.sub!(/.*<c>/,'').sub!(/<\/c>.*/,'')
      measure=Measure.find_by_code(i)
      target=Target.find(:first,
        :conditions=>"measure_id=#{measure.id} and period='#{@period}'")

      i=target.achieved rescue ""
    }
  end
end