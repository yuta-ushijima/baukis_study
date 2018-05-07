class StaffMember < ActiveRecord::Base
  has_many :events, class_name: 'StaffEvent', dependent: :destroy
  # 次の書き方でも同じ動作をする  has_many :StaffEvent, dependent: destroy

  before_validation do
    # バリデーションが行われる前にStaffMemberオブジェクトに対して、以下がコールバックされる
    self.email_for_index = email.downcase if email
  end

  def password=(raw_password)
    # kind_ofメソッドを使って文字列かどうかを判定し、trueなら
    #  BCrypt::Password.createでそのハッシュ値を生成し、それをhashed_passwordにセットする
    if raw_password.kind_of?(String)
      self.hashed_password = BCrypt::Password.create(raw_password)
      elsif raw_password.nil?
      self.hashed_password = nil
    end
  end

  def active?
    !suspended? && start_date <= Date.today &&
      (end_date.nil? || end_date > Date.today)
  end
end
