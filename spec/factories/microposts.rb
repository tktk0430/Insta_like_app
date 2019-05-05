FactoryBot.define do
  factory :micropost do
    association :contributer, factory: :user
    image {Rack::Test::UploadedFile.new(Rails.root.join('test', 'fixtures', 'files', 'tapir.jpg'), 'image/jpeg')}
    content {"hogehoge"}
  end
end
