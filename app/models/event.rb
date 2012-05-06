require 'csv'

class Event < ActiveRecord::Base
    attr_accessible :event, :info1, :info2, :info3, :time, :user_id
    belongs_to :user
    
    def self.generate_csv
      fields = ["user_id", "time", "event", "info1", "info2", "info3"]
      CSV.open("public/events.csv", "wb") do |csv|
        csv << fields
        conn = Event.connection
        sql = "SELECT user_id, time, event, info1, info2, info3 FROM events ORDER BY user_id, time"
        result = conn.execute sql
        result.each do |row|
          csv << fields.map { |f| 
            if f == "time"
              time = row["time"].to_time
              time.to_i * 1000 + time.usec / 1000
            else   
              row[f] 
            end
          } 
        end
=begin
        Event.find_each do |e|        
          csv << fields.map { |f| 
            if f == :time
              e.time.to_time.to_i * 1000 + e.time.usec / 1000
            else   
              e.send(f) 
            end
          } 
        end 
=end                                
      end  
    end
end
