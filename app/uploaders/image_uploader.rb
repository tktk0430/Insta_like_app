class ImageUploader < Shrine
  plugin :validation_helpers

  Attacher.validate do
    validate_max_size 5*1024*1024, message: "5MB以下の画像のみ投稿できます"
    #validate_mime_type_inclusion %w[image/jpeg image/png]
    validate_extension_inclusion %w[jpg jpeg png], message: "画像はjpgかpngのみ投稿できます"
  end
end