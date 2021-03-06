require File.expand_path '../spec_helper.rb', __FILE__

describe "DeployLogger Application" do

    def app
        Sinatra::Application
    end

    let(:deployer) { 'deployer'}
    let(:tag) {'1234556'}
    let(:application) {'bakery'}
    let(:environment) {'production'}

    describe "/health" do
        it "should passes health check" do
            get '/health'
            expect(last_response).to be_ok
        end
    end

    describe '/api/deploy/log' do
        describe 'post' do
            it "should save deploy log" do
                params = {
                    deployer: deployer,
                    tag: tag,
                    application: application,
                    environment: environment
                }
                post '/api/deploy/log', params
                expect(last_response).to be_ok
            end
        end

        describe 'get' do
            before(:each) do
                create(:deploy_log, deployer: "deployer_1", tag: "tag_1")
                create(:deploy_log, deployer: "deployer_1", tag: "tag_2")
                create(:deploy_log, deployer: "deployer_2", tag: "tag_1", application: 'adserver')
                create(:deploy_log, deployer: "deployer_2", tag: "tag_2", application: 'adserver')
                create(:deploy_log, deployer: "deployer_2", tag: "tag_4", application: 'adserver')
                create(:deploy_log, deployer: "deployer_2", tag: "tag_5", application: 'adserver')
                create(:deploy_log, deployer: "deployer_3", tag: "tag_1", application: 'adserver', environment: "staging")
                create(:deploy_log, deployer: "deployer_3", tag: "tag_2", application: 'adserver', environment: "staging")
                create(:deploy_log, deployer: "deployer_3", tag: "tag_3", application: 'adserver', environment: "staging")
            end

            it "should return 400 for missing parameters" do
                post '/api/deploy/log', {}
                expect(last_response.status).to eq(404)
            end

            it "should get the recent deploys by application in json" do
                get '/api/deploy/log.json'
                expect(last_response).to be_ok
                response = JSON.parse last_response.body
                expect(response.count).to eq(3)
                expect(response.first['id']).to eq(6)
                expect(response.first['tag']).to eq('tag_5')
                expect(response.first['application']).to eq('adserver')
                expect(response.first['environment']).to eq('production')
            end

            it "should get the recent deploys by application in html" do
                get '/api/deploy/log'
                expect(last_response).to be_ok
            end

            it "should get the recent deploys by application for staging in json" do
                get '/api/deploy/log/staging.json'
                expect(last_response).to be_ok
                response = JSON.parse last_response.body
                expect(response.count).to eq(1)
                expect(response.first['id']).to eq(9)
                expect(response.first['tag']).to eq('tag_3')
                expect(response.first['application']).to eq('adserver')
                expect(response.first['environment']).to eq('staging')
            end
            it "should get the recent deploys by application for production in json" do
                get '/api/deploy/log/production.json'
                expect(last_response).to be_ok
                response = JSON.parse last_response.body
                expect(response.count).to eq(2)
                expect(response.first['id']).to eq(6)
                expect(response.first['tag']).to eq('tag_5')
                expect(response.first['application']).to eq('adserver')
                expect(response.first['environment']).to eq('production')
                expect(response.last['id']).to eq(2)
                expect(response.last['tag']).to eq('tag_2')
                expect(response.last['application']).to eq('bakery')
                expect(response.last['environment']).to eq('production')

            end
        end
    end
end
