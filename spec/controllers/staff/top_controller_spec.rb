# encoding: UTF-8
require 'rails_helper'

describe Staff::TopController do
  context 'ログイン前' do
    let(:staff_member) { create(:staff_member)}

    before do
      session[:staff_member_id] = staff_member.id
      session[:last_access_time] = 1.second.ago
    end

    describe '#index' do
      it '通常はstaff/top/indexを表示' do
        get :index
        expect(response).to render_template('staff/top/index')
      end

      it '停止フラグがセットされていたら強制的にログアウト' do
        staff_member.update_column(:suspended, true)
        get :index
        expect(session[:staff_member_id]).to be_nil
        expect(session[response]).to redirect_to(staff_root_url)
      end

      it 'セッションタイムアウト' do
        session[:last_access_time] =
        # advanceメソッドで-1秒進める=1秒前に遡らせることで60分1秒前の時間がsession[:last_access_time]にセットされ、セッションタイムアウトを引き起こしている
        Staff::Base::TIMEOUT.seconds.ago.advance(seconds: -1)
        get :index
        expect(session[:staff_member_id]).to be_nil
        expect(response).to redirect_to(staff_login_url)
      end
    end
  end
end
