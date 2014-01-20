task :fix_comments => :environment do
	Comment.where(:forum_id => nil).each do |comment|
		comment.forum_id = comment.parent.forum_id

		comment.save
	end
end
