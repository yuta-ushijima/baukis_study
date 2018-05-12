# encoding: UTF-8
require 'rails_helper'

RSpec.describe Administrator, :type => :model do
  describe '#password=' do
    it '文字列を与えると、hashed_passwordの長さは60になる' do
      admin = Administrator.new
      admin.password = "admin"
      expect(admin.hashed_password).to be_kind_of(String)
      expect(admin.hashed_password.size).to eq(60)
    end

    it "nilを与えるとhashed_passwordはnilになる" do
      admin = Administrator.new(hashed_password: "y")
      admin.password = nil
      expect(admin.hashed_password).to be_nil
    end
   end
end
