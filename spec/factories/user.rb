FactoryBot.define do
    factory :user do
        email { 'factory.test@example.com' }
        password { 'password' }
    end
end