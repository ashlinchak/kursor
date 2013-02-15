namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do

    require 'populator'
    require 'faker'

    [PostingCategory, PostingCategorizing, Posting, Event, EventCategory, EventCategorizing, Tag, Tagging, Image, Adv::Posting, Adv::Category].each(&:delete_all)

    ActiveRecord::Base.connection.execute("ALTER TABLE posting_categories AUTO_INCREMENT = 1;")
    ActiveRecord::Base.connection.execute("ALTER TABLE posting_categorizings AUTO_INCREMENT = 1;")
    ActiveRecord::Base.connection.execute("ALTER TABLE postings AUTO_INCREMENT = 1;")
    ActiveRecord::Base.connection.execute("ALTER TABLE events AUTO_INCREMENT = 1;")
    ActiveRecord::Base.connection.execute("ALTER TABLE event_categories AUTO_INCREMENT = 1;")
    ActiveRecord::Base.connection.execute("ALTER TABLE event_categorizings AUTO_INCREMENT = 1;")
    ActiveRecord::Base.connection.execute("ALTER TABLE taggings AUTO_INCREMENT = 1;")
    ActiveRecord::Base.connection.execute("ALTER TABLE tags AUTO_INCREMENT = 1;")
    ActiveRecord::Base.connection.execute("ALTER TABLE images AUTO_INCREMENT = 1;")
    ActiveRecord::Base.connection.execute("ALTER TABLE adv_categories AUTO_INCREMENT = 1;")
    ActiveRecord::Base.connection.execute("ALTER TABLE adv_postings AUTO_INCREMENT = 1;")

    # Posting categories

    # First need to create hardcoded root categories (project specific)
    PostingCategory.create! do |cat|
        cat.name = 'Posts'
        cat.description = Populator.sentences(1..2)
        cat.created_at = 6.months.ago..9.months.ago
        cat.permalink = 'posts'
    end
    PostingCategory.create! do |cat|
        cat.name = 'Blogs'
        cat.description = Populator.sentences(1..2)
        cat.created_at = 6.months.ago..9.months.ago
        cat.permalink = 'blog'
    end
    PostingCategory.create! do |cat|
        cat.name = 'Wiki'
        cat.description = Populator.sentences(1..2)
        cat.created_at = 6.months.ago..9.months.ago
        cat.permalink = 'wiki'
    end
    PostingCategory.create! do |cat|
        cat.name = 'Video'
        cat.description = Populator.sentences(1..2)
        cat.created_at = 6.months.ago..9.months.ago
        cat.permalink = 'video'
    end
    # After that let's create some subcategories
    PostingCategory.populate 2..5 do |cat|
      cat.name = Populator.words(1).titleize
      cat.description = Populator.sentences(1..2)
      cat.created_at = 6.months.ago..9.months.ago
      cat.permalink = cat.name
      cat.parent_id = PostingCategory.find_by_permalink('posts').id
    end
    PostingCategory.populate 2..5 do |cat|
      cat.name = Populator.words(1).titleize
      cat.description = Populator.sentences(1..2)
      cat.created_at = 6.months.ago..9.months.ago
      cat.permalink = cat.name
      cat.parent_id = PostingCategory.find_by_permalink('wiki').id
    end
    PostingCategory.populate 2..5 do |cat|
      cat.name = Populator.words(1).titleize
      cat.description = Populator.sentences(1..2)
      cat.created_at = 6.months.ago..9.months.ago
      cat.permalink = cat.name
      cat.parent_id = PostingCategory.find_by_permalink('blog').id
    end
    PostingCategory.populate 2..5 do |cat|
      cat.name = Populator.words(1).titleize
      cat.description = Populator.sentences(1..2)
      cat.created_at = 6.months.ago..9.months.ago
      cat.permalink = cat.name
      cat.parent_id = PostingCategory.find_by_permalink('video').id
    end
    #TODO Downcase all posting categories permalinks

    # Postings
    Posting.populate 200 do |p|
      p.title = Populator.words(7..9).titleize
      p.excerpt = Populator.sentences(4..6)
      p.body = Populator.paragraphs(5..15)
      p.user_id = Administrator.first.user_id
      p.created_at = p.published_at = 6.months.ago..Time.now
      p.is_approved = true
      p.posting_type_id = 0 # text (mysql default is 0)
      Image.populate 1 do |i|
        i.imageable_id = p.id
        i.imageable_type = 'Posting'
      end
      PostingCategorizing.populate 1 do |cat|
        @root_cat = PostingCategory.roots.find(rand(1..4)) # Find random root category
        cat.posting_id = p.id
        cat.posting_category_id = @root_cat
        PostingCategorizing.populate 1..@root_cat.children.size do |child|
          child.posting_id = p.id
          child.posting_category_id = @root_cat.children.offset(rand(@root_cat.children.count)).first
        end
      end
      Tag.populate 5..10 do |tag|
        @tag_name = Populator.words(1..2)
        if Tag.find_by_name(@tag_name).present?
          tag.name = @tag_name + (1..2).map{ ('a'..'z').to_a[rand(26)] }.join # Add 2 random letters to name for unique tag name
        else
          tag.name = @tag_name
        end
        tag.created_at = p.created_at
        Tagging.populate 1 do |tagging|
          tagging.taggable_id = p.id
          tagging.taggable_type = 'Posting'
          tagging.tag_id = tag.id
          tagging.created_at = p.created_at
        end
      end
    end


    # Adv::Category
    Adv::Category.populate 12 do |cat|
      cat.permalink = Populator.words(1)
      cat.name = cat.permalink.titleize
      cat.description = Populator.paragraphs(1)
    end
    # Adv::Posting
    Adv::Posting.populate 100 do |adv_posting|
      adv_posting.category_id = 1..12
      adv_posting.title = Populator.words(3..5).titleize
      adv_posting.posting_type_id = 0..1
      adv_posting.owner_type_id = 0..1
      adv_posting.body = ''
      1.times do
        adv_posting.body = adv_posting.body + '<p>' + Populator.paragraphs(1) + '</p>'
      end
      adv_posting.location_id = Address::Location.first.id
      adv_posting.contact_person = Faker::Name.name
      adv_posting.email = Faker::Internet.email
      adv_posting.price = 40..1000
      adv_posting.published_at = 6.months.ago..Time.now
      adv_posting.user_id = Administrator.first.id
    end


    ###########

    # Event Categories and Events
    EventCategory.populate 6 do |event_cat|
      event_cat.name = Populator.words(1).titleize
      event_cat.description = ''
      1..2.times do
        event_cat.description = event_cat.description + '<p>' + Populator.paragraphs(1) + '</p>'
      end
      event_cat.created_at = 6.months.ago..Time.now
      event_cat.permalink = event_cat.name

      Event.populate 10..50 do |event|
        event.title = Populator.words(3..8).titleize
        event.description = ''
        3..4.times do
          event.description = event.description + '<p>' + Populator.paragraphs(1) + '</p>'
        end
        event.eventable_id = Provider.last.id
        event.eventable_type = 'Provider'
        event.location_id = Provider.last.location.id
        event.start_datetime = (Time.now + 2.days)..(Time.now + 120.days)
        event.end_datetime = event.start_datetime
        event.min_price = 100..2000
        event.teacher = Faker::Name.name
        event.created_at = event.start_datetime - 20.days
        EventCategorizing.populate 1 do |categorizings|
          categorizings.event_id = event.id
          categorizings.event_category_id = event_cat.id
          categorizings.created_at = event.created_at
        end
      end

    end


    #Category.populate 20 do |category|
    #  category.name = Populator.words(1..3).titleize
    #  Product.populate 10..100 do |product|
    #    product.category_id = category.id
    #    product.name = Populator.words(1..5).titleize
    #    product.description = Populator.sentences(2..10)
    #    product.price = [4.99, 19.95, 100]
    #    product.created_at = 2.years.ago..Time.now
    #  end
    #end


    #Person.populate 100 do |person|
    #  person.name    = Faker::Name.name                                                                               &:delete_all
    #  person.company = Faker::Company.name
    #  person.email   = Faker::Internet.email
    #  person.phone   = Faker::PhoneNumber.phone_number
    #  person.street  = Faker::Address.street_address
    #  person.city    = Faker::Address.city
    #end
  end
end