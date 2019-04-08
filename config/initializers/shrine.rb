require "shrine"


if Rails.env.production?
  require "shrine/storage/s3"
  s3_options = {
    access_key_id:     ENV['S3_ACCESS_KEY_ID'],
    secret_access_key: ENV['S3_SECRET_ACCESS_KEY'],
    region:            ENV['S3_REGION'],
    bucket:            ENV['S3_BUCKET']
  }

  Shrine.storages = {
    cache: Shrine::Storage::S3.new(prefix: 'cache', **s3_options),
    store: Shrine::Storage::S3.new(prefix: 'store', **s3_options)}
else
  require "shrine/storage/file_system"
  
  Shrine.storages = {
    cache: Shrine::Storage::FileSystem.new("public", prefix: "uploads/cache"), # temporary
    store: Shrine::Storage::FileSystem.new("public", prefix: "uploads"),       # permanent
}
end

Shrine.plugin :activerecord
Shrine.plugin :cached_attachment_data
Shrine.plugin :remove_invalid
Shrine.plugin :validation_helpers
Shrine.plugin :determine_mime_type
