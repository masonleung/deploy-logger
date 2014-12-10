FactoryGirl.define do
    factory :deploy_log do
        deployer "deployer_1"
        tag "1"
        application "bakery"
        environment "production"
    end    
end