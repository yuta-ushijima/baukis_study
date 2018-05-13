require "nkf"

module StringNormalizer
  extend ActiveSupport::Concern

  def normalize_as_email(text)
    NKF.nkf('-w -Z1', text).strip if text
  end

  def normalize_as_name(text)
    NKF.nkf('-w -Z1', text).strip if text
  end

  def normalize_as_furigana(text)
    NKF.nkf('-W -w -Z1 --katakana', text).strip if text
  end

  def normalize_as_postal_code(text)
    # 郵便番号に含まれる全角文字を半角文字に変換後、マイナス記号を除去
    NKF.nkf('-W -w -Z1', text).strip.gsub(/-/, '') if text
  end

  def normalize_as_phone_number(text)
    NKF.nkf('-W -w -Z1 --katakana', text).strip if text
  end
end
