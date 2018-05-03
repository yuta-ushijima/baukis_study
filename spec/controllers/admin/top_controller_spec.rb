# encoding: UTF-8
require 'rails_helper'

describe Admin::TopController do
  context 'ログイン前' do
    let(:administrator) { create(:administrator)}

    before do
      session[:administrator_id] = administrator.id
      session[:last_access_time] = 1.second.ago
    end

    describe '#index' do
      it '通常はstaff/top/indexを表示' do
        get :index
        expect(response).to render_template('admin/top/dashbord')
      end

      it '停止フラグがセットされていたら強制的にログアウト' do
        administrator.update_column(:suspended, true)
        get :index
        expect(session[:administrator_id]).to be_nil
        expect(session[response]).to redirect_to(admin_root_url)
      end

      it 'セッションタイムアウト' do
        session[:last_access_time] =
        # advanceメソッドで-1秒進める=1秒前に遡らせることで60分1秒前の時間がsession[:last_access_time]にセットされ、セッションタイムアウトを引き起こしている
        Admin::Base::TIMEOUT.seconds.ago.advance(seconds: -1)
        get :index
        expect(session[:administrator_id]).to be_nil
        expect(response).to redirect_to(admin_login_url)
      end
    end
  end
end
