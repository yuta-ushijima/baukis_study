require 'rails_helper'

feature '職員による顧客管理' do
  include FeatureSpecHelper
  # letでメモ化されたヘルパーメソッドを定義。
  let(:staff_member) { create(:staff_member) }
  # customerをlet!で即時オブジェクトを作成している理由は、expectメソッドまでcustomerオブジェクトが呼び出されないので、click_button '更新'までに少なくとも1つのcustomerオブジェクトがDBに保存されていないと、testがパスしないため。
  let!(:customer) { create(:customer) }

  before do
    switch_namespace(:staff)
    login_as_staff_member(staff_member)
  end

  scenario '職員が顧客、自宅住所、勤務先を更新する' do
    click_link '顧客管理'
    first('table.listing').click_link '編集'

    fill_in 'メールアドレス', with: 'test@example.jp'
    within('fieldset#home-address-fields') do
      fill_in '郵便番号', with: '9999999'
    end
    within('fieldset#work-address-fields') do
      fill_in '会社名', with: 'テスト'
    end
    click_button '更新'

    customer.reload
    expect(customer.email).to eq('test@example.jp')
    expect(customer.home_address.postal_code).to eq('9999999')
    expect(customer.work_address.company_name).to eq('テスト')
  end
end
