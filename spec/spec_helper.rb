ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../../config/environment", __FILE__)
require "rspec/rails"

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migraiton.check_pending! if defined?(ActiveRecord::Migraiton)

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.order = "random"
  
  # FactoryGirlのモジュールを読み込んで、テストの中で構文が使えるようにする
  config.include FactoryGirl::Syntax::Methods
  
  # RSpecのエグザンプルの集合体であるスイートを実行前にFactoryGirlをリロード
  config.before(:suite) do
    FactoryGirl.reload
  end
end
