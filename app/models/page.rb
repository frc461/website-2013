class Page < ActiveRecord::Base
  attr_accessible :content, :navigable, :parent_id, :title
end
