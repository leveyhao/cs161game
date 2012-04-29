class EventController < ApplicationController

    def record
        event_data = ActiveSupport::JSON.decode(params[:eventdata])
        events = event_data.map { |d| 
            Event.new(d)
        }
        Event.import events, :validate => false

        respond_to do |format|  
            format.html { redirect_to root_url }  
            format.js   { render :nothing => true }  
        end
    end
end
