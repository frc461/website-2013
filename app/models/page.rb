class Page < ActiveRecord::Base
	attr_accessible :content, :navigable, :parent_id, :title, :tag_list, :sort_index
	
	has_many :pages, :foreign_key => :parent_id
	
	belongs_to :parent, :foreign_key => :parent_id, :class_name => :Page
	
	validates :title, format: { with: /^[a-zA-Z0-9\-: ]+$/ }
	validates :sort_index, presence: true
	validates :title, uniqueness: true

	alias_attribute :name, :title

	acts_as_taggable
end
