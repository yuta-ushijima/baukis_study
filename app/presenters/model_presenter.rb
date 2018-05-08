class ModelPresenter
  attr_reader :object, :view_context
  # 引数に指定した名前のインスタンスメソッドを定義し、toオプションで指定したメソッドに振る舞いを任せる
  delegate :raw, to: :view_context
  # object/view_contextは読みだし専用

  def initialize(object, view_context)
    @object = object
    @view_context = view_context
  end
end
