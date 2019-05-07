FactoryBot.define do
  factory :user, aliases:[:contributer] do
    TEST_IMAGE_PATH=Rails.root.join('spec', 'fixtures','test.jpg')
    TEST_IMAGE_DATA="{\"original\":{\"id\":\"20a58d5102c605bcb907abebf8050a81.jpg\",\"storage\":\"store\",\"metadata\":{\"filename\":\"test.jpg\",\"size\":992,\"mime_type\":\"image/gif\"}},\"large\":{\"id\":\"a18996d78fb8ed7b949c176b5521e0ab.jpg\",\"storage\":\"store\",\"metadata\":{\"filename\":\"image_processing20190507-16563-1wuuzee.jpg\",\"size\":2113,\"mime_type\":\"image/jpeg\"}},\"small\":{\"id\":\"bf7a69d1b7123f24fdbef48f9daccf84.jpg\",\"storage\":\"store\",\"metadata\":{\"filename\":\"image_processing20190507-16563-1h6k05n.jpg\",\"size\":2113,\"mime_type\":\"image/jpeg\"}}}"
    
    name {"test"}
    sequence(:account) {|n| "tester#{n}"}
    sequence(:email) {|n| "tester#{n}@gmail.com"}
    password {"hogehoge"}
    password_confirmation {"hogehoge"}
    image_data {TEST_IMAGE_DATA}
  end
end