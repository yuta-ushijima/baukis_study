class Admin::TopController < ApplicationController #rootでnamesapceメソッドを使っているので、adminモジュールを呼び出し
  def index
    raise IpAddressRejected
  end
end
