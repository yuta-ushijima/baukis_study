class StaffMember < ActiveRecord::Base
  # include StringNormalizer #=>EmailHolderへ移管
  include EmailHolder
  include PersonalNameHolder
  include PasswordHolder

  has_many :events, class_name: 'StaffEvent', dependent: :destroy
  # 次の書き方でも同じ動作をする  has_many :StaffEvent, dependent: destroy

  # before_validation do
  #   # バリデーションが行われる前にStaffMemberオブジェクトに対して、以下がコールバックされる
  #   #=>EmailHolderへ移管
  #   # self.email = normalize_as_email(email)
  #   # self.email_for_index = email.downcase if email
  #   # PersonalNameHolderモジュールへ移管
  #   # self.family_name = normalize_as_name(family_name)
  #   # self.given_name = normalize_as_name(given_name)
  #   # self.family_name_kana = normalize_as_furigana(family_name_kana)
  #   # self.given_name_kana = normalize_as_furigana(given_name_kana)
  # end

  # PersonalNameHolderモジュールへ移管
  # KATAKANA_REGEXP = /\A[\p{katakana}\u{30fc}]+\z/
  # PersonalNameHolderモジュールへ移管
  # HUMAN_NAME_REGEXP = /\A[\p{han}\p{hiragana}\p{katakana}\u{30fc}\p{alpha}]+\z/

  # PersonalNameHolderモジュールへ移管
  # validates :family_name, :given_name, presence: true,
  # format: { with: HUMAN_NAME_REGEXP, allow_blank: true}
  # validates :family_name_kana, :given_name_kana, presence: true,
  # format: { with: KATAKANA_REGEXP, allow_blank: true }
  validates :start_date, presence: true, date: {
    after_or_equal_to: Date.new(2000, 1, 1),
    before: -> (obj) { 1.year.from_now.to_date },
    allow_blank: true
  }
  validates :end_date, date: {
    after: :start_date,
    before: -> (obj) { 1.year.from_now.to_date },
    allow_blank: true
  }
  # validates :email, presence: true, email: { allow_blank: true }
  #=>EmailHolderへ移管

  #=>EmailHolderへ移管
  # validates :email_for_index, uniqueness: { allow_blank: true}
  # after_validation do
  #   if errors.include?(:email_for_index)
  #     errors.add(:email, :token)
  #     errors.delete(:email_for_index)
  #   end
  # end

  # def password=(raw_password)#=> PasswordHolderに移管
  #   # kind_ofメソッドを使って文字列かどうかを判定し、trueなら
  #   #  BCrypt::Password.createでそのハッシュ値を生成し、それをhashed_passwordにセットする
  #   if raw_password.kind_of?(String)
  #     self.hashed_password = BCrypt::Password.create(raw_password)
  #     elsif raw_password.nil?
  #     self.hashed_password = nil
  #   end
  # end

  def active?
    !suspended? && start_date <= Date.today &&
      (end_date.nil? || end_date > Date.today)
  end
end
