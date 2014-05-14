namespace :sort do
	desc "Reset all sorting indexes"
	task :reset => :environment do
		new_index = ENV['NEW_INDEX'] || 50
		Page.all.each do |page_to_reset|
			page_to_reset.sort_index = new_index
			page_to_reset.save
			puts "id = " + page_to_reset.id.to_s + "; sort_index = " + page_to_reset.sort_index.to_s
		end
	end

	desc "Set unset sorting indexes"
	task :set => :environment do
		new_index = ENV['NEW_INDEX'] || 50
		Page.where(:sort_index => nil).each do |page_to_set|
			page_to_set.sort_index = new_index
			page_to_set.save
			puts "id = " + page_to_set.id.to_s + "; sort_index = " + page_to_set.sort_index.to_s
		end
	end
end
