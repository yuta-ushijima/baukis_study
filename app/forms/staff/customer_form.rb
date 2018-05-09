class Staff::CustomerForm
  include ActiveModel::Model

  attr_accessor :customer
  # perssisted?メソッドはモデルオブジェクトがDBに保存されているかどうかを真偽地で返す。
  delegate :perssisted?, to: :customer

  def initialize(customer = nil)
    @customer = customer
    # 引数customerが指定されていない場合は、Customer.newでeCustomerオブジェクトを作成。
    # 初期値には、gender属性をmaleに指定。
    @customer ||= Customer.new(gender: 'male')
    # CustomerオブジェクトにHomeAddressオブジェクトを結びつけ
    # 詳細 https://railsguides.jp/association_basics.html#%E9%96%A2%E9%80%A3%E4%BB%98%E3%81%91%E3%81%AE%E8%A9%B3%E7%B4%B0%E6%83%85%E5%A0%B1
    @customer.build_home_address unless @customer.home_address
    # CustomerオブジェクトにWorkAddressオブジェクトを結びつけ
    # 詳細 https://railsguides.jp/association_basics.html#%E9%96%A2%E9%80%A3%E4%BB%98%E3%81%91%E3%81%AE%E8%A9%B3%E7%B4%B0%E6%83%85%E5%A0%B1
    @customer.build_work_address unless @customer.work_address
  end
end
