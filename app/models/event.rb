class Event < ActiveRecord::Base
  attr_accessible :content, :endDate, :location, :public, :startDate, :title
end
