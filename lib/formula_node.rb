module FormulaNode
  attr_accessor :period
  def code_value
    text_value.sub(/<code>[a-zA-Z0-9\-\_\.]*<\/code>/) { |i|
      i.sub(/.*<code>/,'').sub(/<\/code>.*/,'')
      measure=Measure.find_by_code(i)
      target=Target.find(:first,
        :conditions=>"measure_id=#{measure.id} and period='#{@period}'")
      i=target.achieved
    }
  end
end