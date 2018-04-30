class Admin::TopController < Admin::Base
  def index
   if current_administrator
     render action: 'dashbord'
   else
     render action: 'index'
   end
  end
end
