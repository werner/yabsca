class General

  #transform a range of dates in targets periods  
  def dates_to_periods(date_from,date_to,frecuency)
    
    period=date_from..date_to

    multi_month=lambda { |u,x| u.month%x==0 ? u.month/x : nil }

    all_periods=[]
    case frecuency
      when Frecuency::Daily
        period.each { |u| all_periods.push(u) }
      when Frecuency::Weekly
        period.each { |u| all_periods.push(u.strftime("%W")+"-"+u.year.to_s) }
      when Frecuency::Monthly
        period.each { |u| all_periods.push(u.month.to_s+"-"+u.year.to_s) }
      when Frecuency::Bimonthly,Frecuency::Three_monthly,Frecuency::Four_monthly
        period.each do |u|
          all_periods.push(multi_month.call(u,frecuency).to_s+"-"+u.year.to_s) unless
                                                multi_month.call(u,frecuency).nil?
        end
      when Frecuency::Yearly
        period.each { |u| all_periods.push(u.year) }
    end

    all_periods.uniq!    
  end

end
