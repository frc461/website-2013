namespace :photo do
	desc 'import a directory of pictures & shove them to heroku'
	task :import, [:path, :id] => :environment do |t, args|
		require 'net/http'
		uri = URI.parse('http://wbi-website.herokuapp.com/photos')
		count = 0
		Dir.glob(args[:path] + '/*.jpg').entries.each do |e|
			local = Photo.new
			local.image = File.open(e)
			remote_file_name = local.image_file_name
			remote_content_type = local.image_content_type
			remote_file_size = local.image_file_size
			remote_updated_at = local.image_updated_at

			req = Net::HTTP:Post.new(uri.path)
			req.set_form_data('album_id' => params[:id], 'image_file_name' => remote_file_name, 'image_content_type' => remote_content_type, 'image_file_size' => remote_file_size, 'image_updated_at' => remote_updated_at)
			res = Net::HTTP.start(uri.host, uri.port) do |http|
				http.request(req)
			end
			case res
				when Net::HTTPSuccess, Net::HTTPRedirection
					puts `scp -r #{e} boilerin@boilerinvasion.org:/home3/boilerin/public_html/assets/photos/`
					count += 1
				else
					puts "Post failed for #{e}"
			end
			
			local.delete
		end
		puts "Uploaded #{count} files!"
	end
end
