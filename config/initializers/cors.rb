# frozen_string_literal: true

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins ['http://localhost:3001', 'http://13.113.76.92', 'https://blog.sibakeny-dev.com', 'http://blog-f.sibakeny-dev.com', 'https://blog-f.sibakeny-dev.com']

    resource '*',
             headers: :any,
             methods: %i[get post put patch delete options head],
             credentials: true
  end
end
