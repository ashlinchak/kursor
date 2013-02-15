namespace :db do

  desc "Recalculate counts"
  task :recount => :environment do

    # Adv::Category postings count calculate
    Adv::Category.all.each do |cat|
      cat.postings_count = cat.postings.count
      cat.save
    end

  end
end
