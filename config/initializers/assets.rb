# staff/admincustomerをアセットプリコンパイルの対象に加える設定
# app/assets/javascript配下にディレクトリを名前空間ごとに作成したので、
# プリコンパイルされるようにファイル名を指定
Rails.application.config.assets.precompile += %w( staff.css admin.css customer.css admin.js staff.js customer.js)
