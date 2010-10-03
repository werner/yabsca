module FormulaNode
  attr_accessor :period, :measure_id
  def code_value
    result=""
    result=text_value

    #for the functions
    result.gsub!(/(sum|average)\(<c>[a-zA-Z0-9\-\_\.]*<\/c>\)/) { |i|
      code=i.sub(/.*<c>/,'').sub(/<\/c>.*/,'').sub("sum",'').sub("average",'').sub(")",'').sub("(",'')
      func=i.match("sum") || i.match("average")

      measure_formula=Measure.find(@measure_id)

      measure=Measure.find_by_code(code)

      result_func=eval("Target."+func.to_s+
                    "(:achieved,:conditions=>['measure_id=? and period_date between ? and ?',
                    #{measure.id},'#{measure_formula.period_from}'.to_date,'#{measure_formula.period_to.to_date}'.to_date])")
    
      i = result_func rescue ""
    }.to_s

    #for the measure code
    result.gsub!(/<c>[a-zA-Z0-9\-\_\.]*<\/c>/) { |i|
      i.sub!(/.*<c>/,'').sub!(/<\/c>.*/,'')
      measure=Measure.find_by_code(i)
      target=Target.find(:first,
        :conditions=>"measure_id=#{measure.id} and period='#{@period}'")

      i = target.achieved rescue ""
    }.to_s

    result
  end

end
