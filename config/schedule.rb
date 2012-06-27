every 1.day, :at => '11:00 pm' do
  command "backup perform --trigger full_backup"
end

every 1.day, :at => '6:00 pm' do
  rake "-s sitemap:refresh"
end
