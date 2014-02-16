class Page < ActiveRecord::Base
	attr_accessible :content, :navigable, :parent_id, :title, :tag_list, :sort_index
	validates_format_of :title, with: /^[a-zA-Z0-9\-: ]+$/
	validates_presence_of :sort_index
	validates_uniqueness_of :title
	has_many :pages, foreign_key: :parent_id
	belongs_to :parent, foreign_key: :parent_id, class_name: :Page

	acts_as_taggable
end
