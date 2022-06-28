Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins 'https://localhost:3001'
      resource '*', 
      headers: :any, 
      methods: [:get, :post, :patch, :put],
      credentials: true
    end
end