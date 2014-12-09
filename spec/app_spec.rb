require File.expand_path '../spec_helper.rb', __FILE__

describe "Deploy logger" do

    it "should passes health check" do
        get '/health'
        expect(last_response).to be_ok
    end
end
