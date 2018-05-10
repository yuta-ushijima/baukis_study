class HomeAddress < Address
  validates :postal_code, :prefecture, :city, :address1, presence: true
  # absenceメソッドは指定された属性が空である事を確かめるバリデーション
  validates :company_name, :division_name, absence: true
end
