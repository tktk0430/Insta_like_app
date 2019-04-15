require "image_processing/mini_magick"

class ImageUploader < Shrine
  plugin :validation_helpers
  plugin :processing # allows hooking into promoting
  plugin :versions   # enable Shrine to handle a hash of files
  plugin :delete_raw, storages: [:store] # delete processed files after uploading

  Attacher.validate do
    validate_max_size 5*1024*1024, message: "は5MB以下でないと投稿できません"
    #validate_mime_type_inclusion %w[image/jpeg image/png]
    validate_extension_inclusion %w[jpg jpeg png], message: "はjpgかpngのみ投稿できます"
  end

  process(:store) do |io, context|
    versions = { original: io } # retain original
    io.download do |original|
      pipeline = ImageProcessing::MiniMagick.source(original)

      versions[:large]  = pipeline.resize_to_limit!(800, 800)
      versions[:small]  = pipeline.resize_to_fill!(300,300)
    end

    versions # return the hash of processed files
  end
end