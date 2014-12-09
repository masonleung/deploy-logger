require File.expand_path '../spec_helper.rb', __FILE__

describe "DeployLogger Application" do

    def app
        Sinatra::Application
    end

    describe "/health" do 
        it "should passes health check" do
            get '/health/'
            expect(last_response).to be_ok
        end
    end

    describe '/api' do

        it "returns 400 for missing parameters" do
            post '/api/deploy/log', {}
            expect(last_response.status).to eq(404) 
        end

        it "should save deploy log" do
            params = {
                deployer: 'mason',
                tag: '123456abcdefg',
                application: 'bakery',
                environment: 'production'
            }
            post '/api/deploy/log', params
            expect(last_response).to be_ok
        end

        it "should get the recent deploy by application" do

        end 
    end
end
