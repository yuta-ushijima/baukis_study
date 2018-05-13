class Customer < ActiveRecord::Base
  include EmailHolder
  include PersonalNameHolder
  include PasswordHolder
  # home_addressとcustomerを1対1の関連付け
  # autosaveオプションにtrueを指定することで常にCistomerオブジェクトがデータベースに保存される前に、関連づけられたオブジェクトも自動的にDBへ保存される。
  has_one :home_address, dependent: :destroy, autosave: true
  # work_addressとcustomerを1対1の関連付け
  has_one :work_address, dependent: :destroy, autosave: true
  has_many :phones, dependent: :destroy
  # ->でProcオブジェクトでブロックを作成し、has_manyの第二引数に指定することで、
  # 関連付けのスコープを作成。(検索の付帯条件)
  # ここでの検索の付帯条件は個人電話番号だけの絞り込み(address_idがnullのもの)に使われている
  has_many :personal_phones, -> { where(address_id: nil).order(:id)},
                class_name: 'Phone', autosave: true

  # EmailHolderモジュールへ移管
  # before_validation do
  #   self.email_for_index = email.downcase if email
  #   self
  # end

  validates :gender, inclusion: { in: %w(male female), allow_blank: true}
  validates :birthday, date: {
    after: Date.new(1900, 1, 1),
    before: -> (obj) { Date.today },
    allow_blank: true
  }

  # def password=(raw_password) #=>PasswordHolderに移管
  #   if raw_password.kind_of?(String)
  #     self.hashed_password = BCrypt::Password.create(raw_password)
  #   elsif raw_password.nil?
  #     self.hashed_password = nil
  #   end
  # end
end
