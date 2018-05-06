class StaffEvent < ActiveRecord::Base
  self.inheritance_column = nil

  # StaffEventモデルがmemberという名前でStaffMemberモデルを参照することを宣言
  belongs_to :member, class_name: 'StaffMember', foreign_key: 'staff_member_id'
  alias_attribute :occurred_at, :created_at
end
