class EventController < ApplicationController

    def record
        event_data = ActiveSupport::JSON.decode(params[:eventdata])
        event = Event.create(event_data)

        respond_to do |format|  
            format.html { redirect_to root_url }  
            format.js   { render :nothing => true }  
        end
    end
end
