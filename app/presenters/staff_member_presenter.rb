class StaffMemberPresenter < ModelPresenter
  # 職員の停止フラグのOn/Offを表現する記号を返す
  # On: BALLOT BOX WITH CHECK(U+2611)
  # Off:BALLOT BOX(U+2610)
  delegate :suspended?, to: :object

  def full_name
    object.family_name + ' ' + object.given_name
  end

  def full_name_kana
    object.family_name_kana + ' ' + object.given_name_kana
  end

  def suspended_mark
    #　もともとは、baukis_study/app/views/admin/staff_members/index.html.erbでm.suspended? ? raw('&#x2611;') : raw('&#x2610')として定義されていた
    # view内で定義されている変数mをobjectで置き換え。
    # ヘルパーメソッドrawをチェインメソッドとしてview_contextに付属させる
    # これにより、モデルプレゼンターを継承しているview_contextにはrawメソッドを含む全ての
    # ヘルパーメソッドが使えるのでエラーにならずに呼び出せる
    # rawは引数に指定した文字をエスケープしない
    # object.suspended ? view_context.row('&#x2611;') : view_context.raw('&#x2610;')
    # delegateを使うと書き方を簡略化できる
    # object.suspended? ? raw('&#x2611;') : raw('&#x2610;')
    # suspended?メソッドはStaffMemberオブジェクト特有のものなので、StaffMemberPresenterで定義することでより簡略化した書き方ができる
    suspended? ?  raw('&#x2611;') : raw('&#x2610;')
  end
end
