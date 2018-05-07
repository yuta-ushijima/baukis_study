class CreateStaffEvents < ActiveRecord::Migration
  def change
    create_table :staff_events do |t|
      # t.integer :staff_member, null :falseとしてもいいが、referencesメソッドの方が可読性が高い
      t.references :staff_member, null: false # 職員レコードへの外部キー
      t.string        :type, null: false                # イベントタイプ
      t.datetime  :created_at, null:  false       # 発生時刻
    end

      add_index :staff_events, :created_at
      add_index :staff_events, [ :staff_member_id, :created_at ]
      # gemのforeignerによって提供されている。第一引数に参照元テーブル名、第二引数に参照先テーブル名を渡す。
      add_foreign_key :staff_events, :staff_members
  end
end
