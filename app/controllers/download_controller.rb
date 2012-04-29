class DownloadController < ApplicationController
   
   def download    
    Event.generate_csv          
    send_file("#{Rails.root}/public/events.csv", :type => "application/csv")    
   end
end
