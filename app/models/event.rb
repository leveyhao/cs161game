class Event < ActiveRecord::Base
    attr_accessible :event, :info1, :info2, :info3, :time, :user_id
    belongs_to :user
end
