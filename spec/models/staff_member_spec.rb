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
end
