class DownloadController < ApplicationController
   
   def download
    Event.generate_csv 
    send_file("/tmp/events.csv", :type => "application/csv")    
   end

   def userdata
    Event.generate_user_csv(params[:user])
    send_file("/tmp/events.csv", :type => "application/csv")
   end
   
end
