class Administrator < ActiveRecord::Base
  include EmailHolder
  include PasswordHolder

  # before_validation do #=>EmailHolderへ移管
  #   self.email_for_index = email.downcase if email
  # end

  # def password=(raw_password) #=> PasswordHolderへ移管
  #   if raw_password.kind_of?(String)
  #     self.hashed_password = BCrypt::Password.create(raw_password)
  #   elsif raw_password.nil?
  #     self.hashed_password = nil
  #   end
  # end
end
