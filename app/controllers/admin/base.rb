# encoding: UTF-8
class Admin::Base < ApplicationController
  private
    def current_administrator
      if session[:administrator_id]
        @current_administrator ||=
          Administrator.find_by(id: session[:administrator_id])
      end

    end

    helper_method :current_administrator

    def authorize
      unless  current_administrator
        flash.alert = '管理者としてログインしてください。'
        redirect_to :admin_login
      end
    end
end
