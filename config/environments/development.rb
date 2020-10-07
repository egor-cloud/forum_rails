Rails.application.configure do
  config.active_job.queue_adapter = :sidekiq

  #Почта
  host = 'localhost:3000'
  config.action_mailer.default_url_options = { host: host }
  config.action_mailer.raise_delivery_errors = true

  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = { :address => '127.0.0.1', :port => 1025 }
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.perform_caching = false
  #Почта

  #Перенаправляет запросы, например с ошибками на встроенные страницы ошибок ails  не на пользовательские.
  # Если мы хотим свои страницы ошибок сделать false
  config.consider_all_requests_local = true
  #Пользовательские страницы ошибок и контроллер errors
  config.consider_all_requests_local = true

  config.cache_classes = false
  config.eager_load = false



  if Rails.root.join('tmp', 'caching-dev.txt').exist?
    config.action_controller.perform_caching = true
    config.action_controller.enable_fragment_cache_logging = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  config.active_storage.service = :local

  config.active_support.deprecation = :log

  config.active_record.migration_error = :page_load

  config.active_record.verbose_query_logs = true

  config.assets.debug = true

  config.assets.quiet = true

  config.file_watcher = ActiveSupport::EventedFileUpdateChecker
end


