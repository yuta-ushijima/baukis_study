class Staff::CustomerForm
  include ActiveModel::Model

  attr_accessor :customer
  # perssisted?メソッドはモデルオブジェクトがDBに保存されているかどうかを真偽地で返す。
  delegate :persisted?, :save, to: :customer

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

  def assign_attributes(params = {})
    @params = params

    customer.assign_attributes(customer_params)
    customer.home_address.assign_attributes(home_address_params)
    customer.work_address.assign_attributes(work_address_params)
  end

  # 真偽値を返すvalid?メソッドを演算子&&で論理積をとれば、全てのオブジェクトでバリデーションが成功するかどうかを調べられる。
  # def valid?
  #   # 演算子&&は左辺がfalseを返した段階で右辺を評価せずにfalseを返すので、このままだとcustomer.home_address.valid?とcustomer.work_address.valid?は評価されない。このため、一つのバリデーションがfalseになると他のバリデーションはスキップされる。
  #   # customer.valid? && customer.home_address.valid? &&
  #   #     customer.work_address.valid?
  #   # ただし、モデル側でautosaveオプションをtrueにした場合は、customerオブジェクトが保存される際にhome_addressオブジェクトとwork_addressオブジェクトも自動保存されるようになるので、保存前に全てのオブジェクトでバリデーションが実行されることになる。そうするとvalid?メソッドで定義が不要になる。
  #   [ customer, customer.home_address, customer.work_address ]
  #     .map(&:valid?).all?
  # end

 # def save
 # saveについても委譲させると、customerメソッドにすべて挙動が一任されるので、autosaveオプションtrueの場合は定義不要になる。
   #  customer.save
   # # if valid?
   # #   ActiveRecord::Base.transaction do
   # #     customer.save!
   # #     customer.home_address.save!
   # #     customer.work_address.save!
   # #   end
   # # end
 # end

  private
    def customer_params
      @params.require(:customer).permit(
        :email, :password, :family_name, :given_name, :family_name_kana, :given_name_kana, :birthday, :gender
      )
    end

    def home_address_params
      @params.require(:home_address).permit(
        :postal_code, :prefecture, :city, :address1, :address2,
      )
    end

    def work_address_params
      @params.require(:work_address).permit(
        :postal_code, :prefecture, :city, :address1, :address2,
        :company_name, :division_name
      )
    end
end
