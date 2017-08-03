namespace :csv do
  desc "Import CSV file into database"
  task import: :environment do
		begin
			file = Roo::CSV.new("public/people.csv")
			User.import_users(file)
		rescue => e
			puts "#{e.message}"
		end
	end
end
