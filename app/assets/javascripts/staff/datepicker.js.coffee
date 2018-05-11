$(document).on 'turbolinks:load', ->
  $('.birthday-picker').datepicker({
    minDate: new Date(1990, 1, 1),
    maxDate: new Date(),
    # changeMonthとchangeYearにtrueを指定すると、年と月を選択するドロップダウンリストが表示される
    changeMonth: true,
    changeYear: true,
    # yearRangeオプションは、年選択のドロップダウンリストに表示される年の範囲を指定。
    # 開始年と終了年をコロンで区切る。今年を表すには+00と指定する。
    yearRange: '1990:+00',
    # 入力値に値がセットされていない場合にDatepickerが最初に示す日付を文字列で指定する
    defaultDate: '1970-01-01'
    })
