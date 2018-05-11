class Phone < ActiveRecord::Base
  include StringNormalizer

  belongs_to :customer
  belongs_to :address

  before_validation do
    self.number = normalize_as_phone_number(rnumber)
    self.number_for_index = number.gsub(/\D/, ' ') if number
  end

  before_create do
    self.customer = address.customer if address
  end
end
