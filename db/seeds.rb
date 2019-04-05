table_names=%w(users microposts)
table_names.each do |table_name|
  path = Rails.root.join("db/seeds",Rails.env,table_name+".rb")
  if File.exist?(path)
    puts "#{table_name}のシードを作成中。。。"
    require path
  end
end