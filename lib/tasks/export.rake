task :export do
	require 'sequel'
    if RUBY_VERSION < "1.9"
      require "faster_csv"
      CSV = FCSV
    else
      require "csv"
    end
    
    db_url = ( ENV['DATABASE_URL'] || "postgres://jjksovn29p3uvt5s:ydi82xaloclppgl9cxsd3ivpessqzjku@77.92.68.105:10301/db1snor4804xdz7o" )

	db = Sequel.connect(db_url)
	table_name = :events

	table = db[table_name].order(:user_id, :time)
	fields = [:user_id, :time, :event, :info1, :info2, :info3]

	csv = CSV.generate do |csv|
        csv << fields
        
        table.all.each do |record|
            csv << fields.map { |f| 
                if f == :time
                    record[f].to_time.to_i
                else   
                    record[f] 
                end
            }
        end
    end

	puts csv
end
