require_relative './config/environment'

use Rack::Ougai::LogRequests, Application.logger

map '/auth' do
  run UserRoutes
end
