class Event < ActiveRecord::Base
    attr_accessible :event, :info1, :info2, :info3, :time, :user
end
