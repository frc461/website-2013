namespace :photo do
	desc 'import a directory of pictures & shove them to heroku'
	task :import, [:path] => :environment do |t, args|
		Dir.glob(args[:path] + '/*.jpg').entries.each do |e|
			local = Photo.new
			local.image = File.open(e)
			remote_file_name = local.image_file_name
			remote_content_type = local.image_content_type
			remote_file_size = local.image_file_size
			remote_updated_at = local.image_updated_at

			
		end
		
	end
end
