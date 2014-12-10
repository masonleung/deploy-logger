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

    describe '/api' do

        it "returns 400 for missing parameters" do
            post '/api/deploy/log', {}
            expect(last_response.status).to eq(404) 
        end

        it "should save deploy log" do
            params = {
                deployer: deployer,
                tag: tag,
                application: application,
                environment: environment
            }
            binding.pry
            post '/api/deploy/log', params
            expect(last_response).to be_ok
        end

        it "should get the recent deploy by application" do
            # create(:deploy_log, deployer: "deployer_1", tag: "tag_1")
            # create(:deploy_log, deployer: "deployer_1", tag: "tag_2")
            # create(:deploy_log, deployer: "deployer_2", tag: "tag_1", application: 'adserver')
            # create(:deploy_log, deployer: "deployer_2", tag: "tag_2", application: 'adserver')
            # create(:deploy_log, deployer: "deployer_3", tag: "tag_1", application: 'adserver', environment: "staging")
            # create(:deploy_log, deployer: "deployer_3", tag: "tag_2", application: 'adserver', environment: "staging")
            

        end 


    end
end
