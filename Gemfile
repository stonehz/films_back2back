source 'https://rubygems.org'
ruby '1.9.3'
gem 'rails', '3.2.16'
gem 'thin'
gem 'sqlite3'
group :production do
  gem 'mysql2'
  gem 'passenger', :require => false
end
group :assets do
  gem 'sass-rails', '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end
gem 'jquery-rails'
gem 'bootstrap-sass'
gem 'cancan'
gem 'devise'
gem 'figaro'
gem 'rolify'
gem 'simple_form'
gem 'haml-rails'
group :development do
  gem 'html2haml'
  gem 'better_errors'
  gem 'binding_of_caller' #, :platforms=>[:mri_19, :mri_20, :rbx]
  gem 'quiet_assets'
end
group :development, :test do
  gem 'factory_girl_rails'
  gem 'rspec-rails'
end
group :test do
  gem 'capybara'
  gem 'cucumber-rails', :require => false
  gem 'database_cleaner', '1.0.1'
  gem 'email_spec'
  gem 'launchy'
end


gem 'chosen-rails'
gem 'bootstrap-datepicker-rails'
gem 'bootstrap-timepicker-rails'

gem 'execjs'
gem 'therubyracer'
gem 'mobile-fu'
