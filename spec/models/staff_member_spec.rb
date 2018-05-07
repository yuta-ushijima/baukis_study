# encoding: UTF-8
require 'rails_helper'

RSpec.describe StaffMember, :type => :model do
  describe "#password=" do
    it "文字列を与えると、hashed_passwordは長さ60の文字列になる" do
      member  = StaffMember.new
      member.password = "baukis"
      # be_kind_ofはターゲット(=以下の場合はmember.hashed_passwrd)が、
      # ()の中に指定したクラス(=以下の場合はStringクラス)のインスタンスであるかどうかを調べるマッチャー。
      expect(member.hashed_password).to be_kind_of(String)
      expect(member.hashed_password.size).to eq(60)
    end

    it "nilを与えると,hashed_passwordはnilになる" do
      member = StaffMember.new(hashed_password: 'x')
      member.password = nil
      # be_nilはターゲット(=以下の場合はmember.hashed_password)がnilであることを確かめるマッチャー。
      expect(member.hashed_password).to be_nil
    end
  end

  describe '値の正規化' do
    it 'email前後の空白を除去' do
      member = create(:staff_member, email: '  test@example.com  ')
      expect(member.email).to eq('test@example.com')
    end

    it 'exampleに含まれる全角英数記号を半角に変換' do
      member = create(:staff_member, email: 'ｔｅｓｔ＠ｅｘａｍｐｌｅ．ｃｏｍ')
      expect(member.email).to eq('test@example.com')
    end

    it 'email前後の全角スペースを除去' do
      member = create(:staff_member, email: "\u{3000}test@example.com\u{3000}")
      expect(member.email).to eq('test@example.com')
    end

    it 'family_name_kanaに含まれるひらがなをカタカナに変換' do
      member = create(:staff_member, family_name_kana: 'てすと')
      expect(member.family_name_kana).to eq('テスト')
    end

    it 'family_name_kanaに含まれる半角カナを全角カナに変換' do
      member = create(:staff_member, family_name_kana: 'ﾃｽﾄ')
      expect(member.family_name_kana).to eq('テスト')
    end
  end

  describe 'バリデーション' do
    it '@を2個含むemailは無効' do
      member = build(:staff_member, email: 'test@@examle.com')
      expect(member).not_to be_valid
    end

    it '漢字を含むfamily_name_kanaは無効' do
      member = build(:staff_member, family_name_kana: '試験')
      expect(member).not_to be_valid
    end

    it '長音符を含むfamiy_name_kanaは有効' do
      member = build(:staff_member, family_name_kana: 'サリー')
      expect(member).to be_valid
    end

    it '他の職員のメールアドレスと重複したemailは無効' do
      member1 = create(:staff_member)
      member2 = build(:staff_member, email: member1.email)
      expect(member2).not_to be_valid
    end
  end
end
