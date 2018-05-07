class Staff::ChangePasswordForm
  include ActiveModel::Model
  # 上記の記述により、非ActiveRecordモデルにしている
  # しかし、ActiveModel::Modelをincludeされるとsaveメソッドは存在しなくなる

  # attr_accessorで属性を定義し、objectにはStaffMemberオブジェクトがセットされる
  attr_accessor :object, :current_password, :new_password,
        :new_password_confirmation
  validates :new_password, presence: true, confirmation: true

  validate do
    unless Staff::Authenticator.new(object).authenticate(current_password)
      errors.add(:current_password, :wrong)
    end
  end
# フォームオブジェクトが取り扱うオブジェクトを保存するメソッドを付属的機能として定義
  def save
    if valid?
      object.password = new_password
      object.save!
    end
  end
end
