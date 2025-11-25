Sentry.init do |config|
  config.enabled_environments = %w[production staging]

  config.dsn = ENV["SENTRY_DSN"]
  config.environment = ENV.fetch("SENTRY_ENVIRONMENT", Rails.env)

  config.breadcrumbs_logger = %i[sentry_logger active_support_logger monotonic_active_support_logger http_logger]

  config.sample_rate = ENV.fetch("SENTRY_SAMPLE_RATE", 1.0).to_f
  config.traces_sample_rate = ENV.fetch("SENTRY_TRACES_SAMPLE_RATE", 0.1).to_f
  config.send_default_pii = ENV["SENTRY_SEND_DEFAULT_PII"] == "true"
  config.include_local_variables = ENV["SENTRY_INCLUDE_LOCAL_VARIABLES"] == "true"
end