# staff/admincustomerをアセットプリコンパイルの対象に加える設定
Rails.application.config.assets.precompile += %w( staff.css admin.css customer.css )