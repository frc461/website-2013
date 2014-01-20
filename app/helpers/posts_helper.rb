module PostsHelper
	include ActsAsTaggableOn::TagsHelper

	def author(post)
		User.find(post.user_id).name

		rescue ActiveRecord::RecordNotFound
		"Unknown author"
	end
end
