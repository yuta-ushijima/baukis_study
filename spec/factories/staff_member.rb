FactoryGirl.define do
  factory :staff_member do
    sequence(:email) { |n| "member#{n}@example.com" }
    family_name '山田'
    given_name '太郎'
    family_name_kana 'ヤマダ'
    given_name_kana 'タロウ'
    password 'pw'
    start_date { Date.today } #ブロックにDate.todayを入れることで、ファクトリーが生成される時点の昨日の日付がセットされる
    end_date nil
    suspended false
  end
end