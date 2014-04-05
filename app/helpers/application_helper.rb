require 'bluecloth'

module ApplicationHelper
	def yt(text)
		gsubber = text.gsub!(/\[yt\]\[([A-Za-z0-9\-_]+)\]/) do |s|
		"<iframe id=\"ytplayer\" type=\"text/html\" width=\"640\" height=\"390\"
  src=\"http://www.youtube.com/embed/" + $1 + "\" frameborder=\"0\"></iframe>"
		end
	end

	def format(text)
		markdown(text).html_safe
	end

	def markdown(text, options = {})
		options = {
			escape_html: false,
			strict_mode: false
		}.update(options)

		carouselcheck(text)
		photocheck(text)
		linkcheck(text)
		doccheck(text)
		yt(text)

		text = BlueCloth::new(text, options).to_html
	end

	def markback(text)
		return strip_tags(sanitize(format(text)))
	end

	def carouselcheck(text)
		thingnum = 0

		gsubber = text.gsub!(/\[carousel\]\[([0-9,]+)\]\[([0-9,]+)\]/) do |s|
			thingnum += 1
			thing = "<div class=\"container row-fluid\">"
			thing << "<div class=\"span6\">"
			thing << "<div id=\"carousel#{thingnum}\" class=\"carousel slide\">"
			thing << "<div class=\"carousel-inner\">"
			thing << "<div class=\"item active\">"
			thing << image_tag(Photo.find($1.split(",").first).image.url(:medium))
			thing << "</div>"

			$1.split(",").drop(1).each do |photo|
				thing << "<div class=\"item\">"
				thing << image_tag(Photo.find(photo).image.url(:medium))
				thing << "</div>"
			end

			thing << "</div>"
			thing << "<a class=\"carousel-control left\" href=\"#carousel#{thingnum}\" data-slide=\"prev\">&lsaquo;</a>"
			thing << "<a class=\"carousel-control right\" href=\"#carousel#{thingnum}\" data-slide=\"next\">&rsaquo;</a>"
			thing << "</div>"
			thing << "</div>"

			thingnum += 1

			thing << "<div class=\"span6\">"
			thing << "<div id=\"carousel#{thingnum}\" class=\"carousel slide hidden-phone\">"
			thing << "<div class=\"carousel-inner\">"
			thing << "<div class=\"active item\">"
			thing << image_tag(Photo.find($2.split(",").first).image.url(:medium))
			thing << "</div>"

			$2.split(",").drop(1).each do |photo|
				thing << "<div class=\"item\">"
				thing << image_tag(Photo.find(photo).image.url(:medium))
				thing << "</div>"
			end

			thing << "</div>"
			thing << "<a class=\"left carousel-control\" href=\"#carousel#{thingnum}\" data-slide=\"prev\">&lsaquo;</a>"
			thing << "<a class=\"right carousel-control\" href=\"#carousel#{thingnum}\" data-slide=\"next\">&rsaquo;</a>"
			thing << "</div>"
			thing << "</div>"
			thing << "</div>"
			thing <<
<<-JS
<script type=\"text/javascript\">
$(document).ready(function() {
	$('#carousel#{thingnum - 1}').carousel({interval: 10000})
	$('#carousel#{thingnum - 1}').carousel('cycle')

	$('#carousel#{thingnum}').carousel({interval: 10000})
	$('#carousel#{thingnum}').carousel('cycle')
})
</script>
JS
		end
	end

	def photocheck(text)
		gsubber = text.gsub!(/\[[Aa]lbum ([^\[\]]+)\]\[[Pp]hoto (\d+)([otm])?\](\[([rl])\])?/) do |s|
			if s != ""
				begin
					if $3
						style = case $3.downcase
						        when 'o'
							        :original
						        when 't'
							        :thumb
						        when 'm'
							        :medium
						        else
							        :thumb
						        end
					else
						style = :thumb
					end

					if $5
						if $5 == "r"
							image_tag(Photo.where("album_id = ? and id = ?",
							                      Album.where("name LIKE ?", $1).first.id, $2.to_i).first.image.url(style),
							          class: "pull-right floating-content-img")
						elsif $5 == "l"
							image_tag(Photo.where("album_id = ? and id = ?",
							                      Album.where("name LIKE ?", $1).first.id, $2.to_i).first.image.url(style),
							          class: "pull-left floating-content-img")
						end
					else
						image_tag(Photo.where("album_id = ? and id = ?",
						                      Album.where("name LIKE ?", $1).first.id, $2.to_i).first.image.url(style),
						          class: "content-img")
					end
				rescue
					"/!\\ NO SUCH PHOTO /!\\"
				end
			else s
			end
		end
	end

	def linkcheck(text)
		gsubber = text.gsub!(/\[[Pp]age ([^\[\]]+)\](\[([^\[\]]+)\])?/) do |s|
			begin
				if $3
					link_to_page Page.where("title LIKE ?", $1).first, $3
				else
					link_to_page Page.where("title LIKE ?", $1).first
				end
			rescue
				"Error: /!\\ NO SUCH PAGE /!\\"
			end
		end
	end

	def doccheck(text)
		gsubber = text.gsub!(/\[[Dd]oc(ument)? ([^\[\]]+)\](\[([^\[\]]+)\])?/) do |s|
			if s != ""
				begin
					doc = Document.where("name LIKE ?", $2).first
					if $4
						link_to $4, doc.filename
					else
						link_to doc.name, doc.filename
					end
				rescue
					"/!\\ NO SUCH DOCUMENT /!\\"
				end
			end
		end
	end

	def page_path (page, thing = nil)
		if thing #hacky update fix
			return '/pages/' + page.id.to_s
		else
			titles = [page]
			while titles.first.parent_id
				titles.unshift(Page.find(titles.first.parent_id))
			end
			titles.map! do |t|
				t.title.gsub(/ /,"_").gsub(/:/, "~")
			end
			'/pages/' + titles.join("/")
		end
	end

	def link_to_page (page, text = nil, html = "")
		begin
			('<a href="' + page_path(page) + '" ' + html +'>' + (text ? text : page.title) + '</a>').html_safe
		rescue
			"Invalid link specified"
		end
	end

	def format_tweet (tweet)
		text = tweet.text.dup

		# URLs
		tweet.urls.each do |url|
			text.gsub!(url.url, "<a href=\"" + url.expanded_url + "\">" + url.display_url + "</a>")
		end

		# Media
		tweet.media.each do |media|
			text.gsub!(media.url, "<a href=\"" + media.expanded_url.to_s + "\">" + media.display_url + "</a>")
		end

		# Hashtags
		tweet.hashtags.each do |hashtag|
			text.gsub!("#" + hashtag.text, "<a href=\"https://twitter.com/search/?q=%23" + hashtag.text + "\" target=\"_blank\">" + "#" + hashtag.text + "</a>")
		end

		# User mentions
		tweet.user_mentions.each do |user|
			text.gsub!("@" + user.screen_name, "<a href=\"https://twitter.com/" + user.screen_name + "\">" + "@" + user.screen_name + "</a>")
		end

		# Return gsubbed text
		return text
	end

	def parent_array (page)
		if !page.parent_id
			[]
		else
			parent_array(Page.find(page.parent_id)) + [Page.find(page.parent_id)]
		end
	end

	def uri?(string)
		if string.match(/https?:\/\//)
			true
		else
			false
		end
	end

	def title(title_string)
		content_for :title, title_string.to_s
	end

	def join_errors(errors)
		(errors.to_a.join(", ") + ".").capitalize
	end
end
