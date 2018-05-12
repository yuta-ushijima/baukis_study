# encoding: UTF-8
FactoryGirl.define do
  factory :customer do
    sequence(:email) { |n| "member#{n}@example.jp"}
    family_name '山田'
    given_name '太郎'
    family_name_kana 'ヤマダ'
    given_name_kana 'タロウ'
    password 'pw'
    birthday Date.new(1990, 1, 1)
    gender 'male'
    # associationメソッドにより、specファイルの中でオブジェクトに関連づけられたオブジェクトを作成できる。
    # 第一引数にはファクトリーの名前を指定する。
    # strategyオプションにbuildをシンボルで指定すると、buildメソッドで関連づけられるオブジェクトを作成することができる。
    # strategyオプションでbuildを指定する理由は、associationメソッドはデフォルトでcreateメソッドで関連づけオブジェクトを作成するため。
    association :home_address, strategy: :build
    association :work_address, strategy: :build
  end
end
