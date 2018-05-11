# encoding: UTF-8
class FormPresenter
  include HtmlBuilder

  attr_reader :form_builder, :view_context
  delegate :label, :text_field, :password_field, :check_box, :radio_button,
             :text_area, :object, to: :form_builder

 def initialize(form_builder, view_context)
   @form_builder = form_builder
   @view_context = view_context
 end

 def notes
   markup(:dev, class: 'notes') do |m|
     m.span '*', class: 'mark'
     m.text '印のついた項目は入力必須です。'
   end
 end

 def text_field_block(name, label_text, options = {})
   markup(:div, class: 'input-block') do |m|
     m << decorated_label(name, label_text, options)
     m << text_field(name, options)
     m << error_messages_for(name)
   end
 end

 def password_field_block(name, label_text, options = {})
   markup(:div, class: 'input-block') do |m|
     m << decorated_label(name, label_text, options)
     m << password_field(name, options)
     m << error_messages_for(name)
   end
 end

 def date_field_block(name, label_text, options = {})
   markup(:div, class: 'input-block') do |m|
     if options[:class].kind_of?(String)
       classes = options[:class].strip.split + [ 'datepicker' ]
       options[:class] = classes.uniq.join(' ')
     else
       options[:class] = 'datepicker'
     end
     m << decorated_label(name, label_text, options)
     m  << text_field(name, options)
     m << error_messages_for(name)
   end
 end

 def drop_down_list_block(name, label_text, choices, options = {})
   markup(:div, class: 'input-block') do |m|

     m << decorated_label(name, label_text, options)
     # 第二引数に選択項目の配列
     # 第三引数にselectメソッドの振る舞いを扁壺するオプション
     # include_blankオプションにtrueを指定すると空白の選択肢がリストの先頭に加わる
     # 第四引数にはHTMLのselect要素に指定する属性を設定するためのオプションを指定
     m << form_builder.select(name, choices, { include_blank: true}, options)
     m << error_messages_for(name)
   end
 end

 def error_messages_for(name)
   markup do |m|
     object.errors.full_messages_for(name).each do |message|
       m.div(class: 'error-message') do |m|
         m.text message
       end
     end
   end
 end

 private
    def decorated_label(name, label_text, options = {})
      label(name, label_text, class: options [:required] ? 'required' : nil)
    end
end
