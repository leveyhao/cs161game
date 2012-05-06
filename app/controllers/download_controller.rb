class DownloadController < ApplicationController
   
   def download      
    send_file("/tmp/events.csv", :type => "application/csv")    
   end

   def userdata
    Event.generate_user_csv(params[:user])
    send_file("/tmp/events.csv", :type => "application/csv")
   end
   
end
