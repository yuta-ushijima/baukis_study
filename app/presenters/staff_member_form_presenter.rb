# encoding: UTF-8
class StaffMemberFormPresenter < UserFormPresenter
  def check_boxes
    markup(:div, class: 'input-box') do |m|
      m << check_box(:suspended)
      m << label(:suspended, 'アカウント停止')
    end
  end
end
