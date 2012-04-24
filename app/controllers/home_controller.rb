class HomeController < ApplicationController

    before_filter :get_user_id

    def index
    end

    protected
    def get_user_id
        @user_id = cookies.signed[:user_id]
        unless @user_id && User.find_by_id(@user_id)
            user = User.create()
            @user_id = user.id
            cookies.signed[:user_id] = {
                :value => user.id,
                :expires => 2.weeks.from_now 
            }
        end
    end
end
