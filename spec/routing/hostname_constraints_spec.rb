require 'rails_helper'

describe 'ルーティング' do
  it '職員トップページ' do
    expect(get: 'http://baukis.example.com').to route_to(
      host: 'baukis.example.com',
      controller: 'staff/top',
      action: 'index'
    )
  end

  it '管理者ログインフォーム' do
    expect(get: 'http://baukis.example.com/admin/login').to route_to(
      host: 'baukis.example.com',
      controller: 'admin/sessions',
      action: 'new'
    )
  end

  it 'ホスト名が対象外ならerrors/not_foundへ' do
    expect(get: 'http://foo.example.com').to route_to(
      controller: 'errors',
      action: 'routing_error'
    )
  end

  it '存在しないパスならerrors/not_foundへ' do
    expect(get: 'http://baukis.example.com/xyz').to route_to(
      controller: 'errors',
      action: 'routing_error',
      anything: 'xyz'
    )
  end
end
