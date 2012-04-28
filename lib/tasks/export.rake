task :export do
	require 'sequel'
	require 'fastercsv'
    
    db_url = ( ENV['DATABASE_URL'] || "postgres://qktkglndgp:rJLfZ6TaTfKYM04DgAbT@ec2-23-23-217-153.compute-1.amazonaws.com/qktkglndgp" )

	db = Sequel.connect(db_url)

	table_name = :events

	table = db[table_name].order(:user_id, :time)
	fields = [:user_id, :time, :event, :info1, :info2, :info3]

	csv = FasterCSV.generate do |csv|
		csv << fields

		table.all.each do |record|
			csv << fields.map { |f| record[f] }
		end
	end

	puts csv
end
