namespace :users do
  desc "Making all users in database confirmed who has true is_active status"
  task :confirm_all_active => :environment do
    User.where(:is_active => true).each do |user|
      user.update_attributes(:confirmed_at => DateTime.now, :confirmation_token => SecureRandom.base64(15).tr('+/=lIO0', 'pqrsxyz'), :confirmation_sent_at => DateTime.now)
    end
  end
end

