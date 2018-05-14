class Phone < ActiveRecord::Base
  include StringNormalizer

  belongs_to :customer
  belongs_to :address

  before_validation do
    self.number = normalize_as_phone_number(number)
    # \Dの正規表現で数字以外の文字列に全てマッチさせる
    # gsubメソッドの第二引数に空白を入れて、全て除去
    self.number_for_index = number.gsub(/\D/, ' ') if number
    if number_for_index && number_for_index.size >= 4
      self.last_four_digits = number_for_index[-4, 4]
    end
  end

  before_create do
    # オブジェクトが初めてDBに保存される前に実行する処理が以下
    # Addressオブジェクトが関連づけられている場合に、customerオブジェクトと関連付ける
    self.customer = address.customer if address
  end

  validates :number, presence: true,
  # 先頭に+記号が0個または1個以上あり(?のメタ文字)、1個以上の数字が並び、マイナス記号1個と1個以上の数字(\d+)の組み合わせが0個以上(*)末尾まで並ぶ
  format: { with: /\A\+?\d+(-\d+)*\z/, allow_blank: true }

end
