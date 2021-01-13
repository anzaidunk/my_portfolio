source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

gem 'bcrypt', '3.1.12'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'bootstrap', '~> 4.3.1'
gem 'coffee-rails', '4.2.2'
gem 'jbuilder', '~> 2.7'
gem 'jquery-rails'
# gem 'sqlite3', '~> 1.4'
gem 'mysql2', '>= 0.3.18', '< 0.6.0' # DB変更
gem 'puma', '~> 4.1'
gem 'rails', '~> 6.0.3', '>= 6.0.3.3'
gem 'rails-i18n'
gem 'sassc-rails'
gem 'turbolinks', '~> 5'
gem 'uglifier', '3.2.0'
gem 'webpacker', '~> 4.0'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'rspec-rails'
end

group :development do
  gem 'listen', '~> 3.2'
  gem 'pre-commit'
  gem 'rubocop', require: false
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  # gem 'selenium-webdriver'
  gem 'webdrivers'
end

# Windows環境ではtzinfo-dataというgemを含める必要がある
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
