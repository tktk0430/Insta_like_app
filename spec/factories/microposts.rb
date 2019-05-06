FactoryBot.define do
  factory :micropost do
    association :contributer, factory: :user
    image_data {
      "{\"original\":{\"id\":\"8992a1dd01061bc671e31a337904068a.jpg\",\"storage\":\"store\",\"metadata\"
      :{\"filename\":\"tapir.jpg\",\"size\":992,\"mime_type\":\"image/gif\"}},\"large\"
      :{\"id\":\"10919991ff36a07a2c2468afc43004c9.jpg\",\"storage\":\"store\",\"metadata\"
      :{\"filename\":\"image_processing20190506-17791-ysw1he.jpg\",\"size\":2113,\"mime_type\":\"image/jpeg\"}},\"small\"
      :{\"id\":\"e472d58f9269891e98b85b40c42f8f1f.jpg\",\"storage\":\"store\",\"metadata\"
      :{\"filename\":\"image_processing20190506-17791-1m9x5xf.jpg\",\"size\":2113,\"mime_type\":\"image/jpeg\"}}}"
    }
    # image {Rack::Test::UploadedFile.new(Rails.root.join('test', 'fixtures', 'files', 'tapir.jpg'), 'image/jpeg')}
    # 毎回アップロードすると重い
    content {"hogehoge"}
  end
end
