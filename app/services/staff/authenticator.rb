class Staff::Authenticator
  def initialize(staff_member)
    @staff_member = staff_member
  end
  
  def authenticate(raw_password)
      !@staff_member.suspended? && #@staff_memberが有効で
      @staff_member.hashed_password && #@staff_memberにパスワードが設定されてて
      @staff_member.start_date <= Date.today && #@staff_memberの開始日が今日以前で
      (@staff_member.end_date.nil? || @staff_member.end_date > Date.today) && #@staff_memberの終了日が設定されていないか、今日よりも後で
      BCrypt::Password.new(@staff_member.hashed_password) == raw_password #@staff_memberのパスワードが正しければtrueを返す
  end
end