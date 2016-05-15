source 'https://rubygems.org'
ruby '2.2.2'

gem 'rails', '>= 5.0.0.rc1', '< 5.1'
gem 'pg',    '~> 0.18' # Use postgresql as the database for Active Record
gem 'puma',  '~> 3.0'  # Use Puma as the app server
gem 'rails_12factor', group: :production

gem 'sass-rails', '~> 5.0'      # Use SCSS for stylesheets
gem 'uglifier', '>= 1.3.0'      # Use Uglifier as compressor for JavaScript assets
gem 'coffee-rails', '~> 4.1.0'  # Use CoffeeScript for .coffee assets and views
gem 'jquery-rails'              # Use jquery as the JavaScript library
# gem 'therubyracer', platforms: :ruby # JS runtime
gem 'foundation-rails', '~> 6.2.1'
gem 'turbolinks', '~> 5.x' # Turbolinks makes navigating your web application faster.
#   Read more: https://github.com/turbolinks/turbolinks

# gem 'jbuilder', '~> 2.0' # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'redis', '~> 3.0'    # Use Redis adapter to run Action Cable in production
gem 'bcrypt', '~> 3.1.7' # Use ActiveModel has_secure_password

gem 'simple_form'        # Simplify and consolidate form configuration

group :development, :test do
  # gem 'byebug', platform: :mri
  gem 'dotenv-rails'
  gem 'pry-rails'
end

group :test do
  gem 'capybara'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'launchy'
  gem 'database_cleaner'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen', '~> 3.0.5'

  # Spring speeds up development by keeping your application running in the background.
  #   Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'spring-commands-rspec'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
