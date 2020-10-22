source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

gem 'rails', '~> 6.0.3', '>= 6.0.3.2'
gem 'mysql2', '>= 0.4.4'
gem 'puma', '~> 4.1'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 4.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
# gem 'bcrypt', '~> 3.1.7'
gem 'font-awesome-rails'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'bcrypt'

#фронтенд
# gem 'bootstrap'
gem 'will_paginate-bootstrap4'
gem 'will_paginate'

#sidekiq
gem 'redis'
gem 'sidekiq'
gem 'sinatra', require: false
gem 'slim'

#Картинки
gem 'carrierwave'
gem 'mini_magick'

#captcha
gem "recaptcha", require: "recaptcha/rails"

#переменные окружения. Позволяет создавать переменные окружения непосредственно в проекте rails и экспортировать их
gem 'dotenv-rails', :groups => [:development, :test]

# Вложенное дерево категорий
gem 'ancestry'

#лайки
gem 'acts_as_votable'

#доступ в js к обьектам ruby
gem 'gon'

group :development, :test do
  #Почта
  # MailCatcher запускает супер простой SMTP-сервер, который перехватывает любое отправленное ему сообщение для
  # отображения в веб-интерфейсе. Запустите mailcatcher, настройте свое любимое приложение на доставку на
  # smtp: //127.0.0.1: 1025 вместо SMTP-сервера по умолчанию, затем проверьте http://127.0.0.1:1080,
  # чтобы увидеть почту, которая пришла на данный момент.
  gem 'mailcatcher'
  gem 'faker'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails'
  #Красивые выводы rspec
  gem 'fuubar'
end

group :development do
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'pry-doc'
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'shoulda-matchers'
  gem 'factory_bot_rails'
  gem 'database_cleaner'
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
