require "spec_helper"

describe Admin::Authenticator do
  describe "#authenticate" do
    it "正しいパスワードならtrueを返す" do
      m = build(:administrator)
        expect(Admin::Authenticator.new(m).authenticate('pw')).to be_truthy
    end
    
    it "誤ったパスワードならfalseを返す" do
      m = build(:administrator)
        expect(Admin::Authenticator.new(m).authenticate('xy')).to be_falsey
    end
    
    it "パスワードが未設定ならfalseを返す" do
      m = build(:administrator, password: nil)
      expect(Admin::Authenticator.new(m).authenticate(nil)).to be_falsey
    end
    
    it "停止フラグが立っていてもtrueを返す" do
      m = build(:administrator, suspended: true)
      expect(Admin::Authenticator.new(m).authenticate('pw')).to be_truthy
    end
  end
end