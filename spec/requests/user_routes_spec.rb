RSpec.describe UserRoutes, type: :request do
  describe 'POST /sign_up' do
    context 'missing parameters' do
      it 'returns an error' do
        post 'v1/sign_up', params: {name: 'bob', email: 'bob@example.com', password: ''}

        expect(last_response.status).to eq(422)
      end
    end

    context 'invalid parameters' do
      let(:user_params) { {
          name: 'b.o.b',
          email: 'bob@example.com',
          password: 'givemeatoken',
      } }
      it 'returns an error' do
        post 'v1/sign_up', user_params

        expect(last_response.status).to eq(422)
        expect(response_body['errors']).to include(
                                               {
                                                   'detail' => I18n.t(:wrong_name_format, scope: 'contracts'),
                                                   'source' => {
                                                       'pointer' => '/data/attributes/name'
                                                   }
                                               }
                                           )
      end
    end

    context 'valid parameters' do
      let(:user_params) { {
          name: 'bob',
          email: 'bob@example.com',
          password: 'givemeatoken',
      } }
      it 'returns created status' do
        post 'v1/sign_up', user_params

        expect(last_response.status).to eq(201)
      end
    end
  end

  describe 'POST /sign_in' do
    context 'missing parameters' do
      let(:params) { {email: 'bob@example.com',
                      password: ''} }
      it 'returns an error' do
        post 'v1/sign_in', params

        expect(last_response.status).to eq(422)
      end
    end

    context 'invalid parameters' do
      let(:params) { {email: 'bob@example.com',
                      password: 'invalid'} }
      it 'returns an error' do

        post 'v1/sign_in', params

        expect(last_response.status).to eq(401)
        expect(response_body['errors']).to include('detail' => I18n.t(:unauthorized, scope: 'services.user_sessions.create_service'))
      end
    end

    context 'valid parameters' do
      let(:token) { 'jwt_token' }
      let(:params) { {email: 'bob@example.com',
                      password: 'givemeatoken'} }

      before do
        FactoryBot.create(:user, email: 'bob@example.com', password: 'givemeatoken')

        allow(JWT).to receive(:encode).and_return(token)
      end

      it 'returns created status' do
        post 'v1/sign_in', params

        expect(last_response.status).to eq(201)
        expect(response_body['meta']).to eq('token' => token)
      end
    end
  end

  describe "POST /auth" do
    context "valid header" do
      let(:session) {FactoryBot.create(:user_session)}
      let(:token) { JwtEncoder.encode(uuid: session.uuid) }

      it do
        post 'v1/auth', {}, "HTTP_AUTHORIZATION" => "Bearer #{token}"

        expect(last_response.status).to eq(201)
        expect(response_body['meta']).to include("user_id" => session.user.id)
      end
    end

    context "invalid header" do
      let(:token) { 'jwt_token' }
      it do
        post 'v1/auth', {}, "HTTP_AUTHORIZATION" => token

        expect(last_response.status).to eq(422)
        expect(response_body['errors']).to include('detail' => I18n.t(:forbidden, scope: 'services.auth.fetch_user_service'))
      end
    end
  end
end