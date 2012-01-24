namespace :users do
  desc "If user created account and has default account type,
  check it and fix according to existing associations"
  task :fix_account_type => :environment do
    # Iterate through existing providers and update
    # account type to User::ACCOUNT_TYPES['school']
    ::Provider.all.each do |provider|
      provider.user.account_type_id = ::User::ACCOUNT_TYPES.index('school')
      provider.user.save
    end
  end
end

