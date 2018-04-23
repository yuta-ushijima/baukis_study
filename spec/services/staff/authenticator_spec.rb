require "spec_helper"

describe Staff::Authenticator do
  describe "#authenticate" do
    it "正しいパスワードならtrueを返す" do
      m = build(:staff_member)
        expect(Staff::Authenticator.new(m).authenticate('pw')).to be_truthy
    end
    
    it "誤ったパスワードならfalseを返す" do
      m = build(:staff_member)
        expect(Staff::Authenticator.new(m).authenticate('xy')).to be_falsey
    end
    
    it "パスワードが未設定ならfalseを返す" do
      m = build(:staff_member, password: nil)
      expect(Staff::Authenticator.new(m).authenticate(nil)).to be_falsey
    end
    
    it "停止フラグが立って入ればfalseを返す" do
      m = build(:staff_member, suspended: true)
      expect(Staff::Authenticator.new(m).authenticate('pw')).to be_falsey
    end
    
    it "開始前ならfalseを返す" do
      m = build(:staff_member, start_date: Date.tomorrow)
      expect(Staff::Authenticator.new(m).authenticate('pw')).to be_falsey
    end
    
    it "終了後ならfalseを返す" do
      m = build(:staff_member, end_date: Date.today)
      expect(Staff::Authenticator.new(m).authenticate('pw')).to be_falsey
    end
  end
end