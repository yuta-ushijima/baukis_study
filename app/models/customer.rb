class Customer < ActiveRecord::Base

  has_one :home_address, dependent: :destroy # home_addressとcustomerを1対1の関連付け
  has_one :work_address, dependent: :destroy # work_addressとcustomerを1対1の関連付け

  before_validation do
    self.email_for_index = email.downcase if email
    self
  end

  def password=(raw_password)
    if raw_password.kind_of?(String)
      self.hashed_password = BCrypt::Password.create(raw_password)
    elsif raw_password.nil?
      self.hashed_password = nil
    end
  end
end
