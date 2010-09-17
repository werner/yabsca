require "spreadsheet"

class ExcelImport
  attr_accessor :file
  def get_data
    book=Spreadsheet.open @file
    sheet=book.worksheet 0
    sheet.each { |row| 
      measure=Measure.find(:first,:conditions=>["code=?",row[0]])
      unless measure.nil?
        target=Target.find(:first,:conditions=>["measure_id=? and period=?",measure.id,row[1]])
        unless target.nil?
          target.update_attributes({:goal=>row[2],:achieved=>row[3]})
        else
          Target.create({:period=>row[1],:goal=>row[2],:achieved=>row[3],:measure_id=>measure.id})
        end
      end      
    }  
  end  
  
end
