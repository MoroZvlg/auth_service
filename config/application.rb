class Application < Sinatra::Base
  helpers Validations
  helpers Auth

  before do
    Thread.current[:request_id] ||= request.env["HTTP_X_REQUEST_ID"]
  end

  configure do
    register Sinatra::Namespace
    register ApiErrors

    set :app_file, File.expand_path('../config.ru', __dir__)
  end

  configure :development do
    register Sinatra::Reloader

    set :show_exceptions, false
  end
end