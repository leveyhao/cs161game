class EventController < ApplicationController

    def record
        event_data = ActiveSupport::JSON.decode(params[:eventdata])
        event_data.each { |d| 
            Event.create(d)
        }

        respond_to do |format|  
            format.html { redirect_to root_url }  
            format.js   { render :nothing => true }  
        end
    end
end
