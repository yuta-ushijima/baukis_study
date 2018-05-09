class ModelPresenter
  include HtmlBuilder
  attr_reader :object, :view_context
  # 引数に指定した名前のインスタンスメソッドを定義し、toオプションで指定したメソッドに振る舞いを任せる
  delegate :raw, :link_to, to: :view_context
  # object/view_contextは読みだし専用

  def initialize(object, view_context)
    @object = object
    @view_context = view_context
  end

  # 顧客情報詳細をERBテンプレートに埋め込むために使用
  def created_at
    object.created_at.try(:strftime, '%Y/%m/%d %H:%M:%S')
  end

  def updated_at
    object.updated_at.try(:strftime, '%Y/%m/%d %H:%M:%S')
  end
end
