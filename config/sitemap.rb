SitemapGenerator::Sitemap.default_host = "http://kursor.org.ua"

#SitemapGenerator::Sitemap.create_index = :auto

SitemapGenerator::Sitemap.search_engines

SitemapGenerator::Sitemap.create do

  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end

  add '/c', :changefreq => 'daily'
  add '/t', :changefreq => 'daily'
  add '/p', :changefreq => 'daily'
  add '/info'

  Posting.find_each do |posting|
    add posting_path(posting), :changefreq => 'daily', :lastmod => posting.updated_at
  end

  Provider.find_each do |provider|
    add provider_path(provider), :changefreq => 'daily', :lastmod => provider.updated_at
  end

  Tutor.find_each do |tutor|
    add tutor_path(tutor), :changefreq => 'daily', :lastmod => tutor.updated_at
  end

  Info.find_each do |info|
    add info_path(info), :lastmod => info.updated_at
  end

  TutorCategory.find_each do |t|
    add tutor_category_path(t), :changefreq => 'daily'
  end

  Category.find_each do |c|
    add category_path(c), :changefreq => 'daily'
  end

  PostingCategory.find_each do |p|
    add posting_category_path(p), :changefreq => 'daily'
  end

end
