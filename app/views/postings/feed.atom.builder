atom_feed :language => 'ru-RU' do |feed|
  feed.title @title
  feed.updated @updated

  @posting_items.each do |item|
    next if item.updated_at.blank?

    feed.entry( item ) do |entry|

      # entry.link "href=\"#{posting_url(item)}\""
      entry.title item.title
      entry.content item.body, :type => 'html'

      # the strftime is needed to work with Google Reader.
      # entry.updated(item.updated_at.strftime("%Y-%m-%dT%H:%M:%SZ"))

      if item.user.visitor?
        entry.author do |author|
          author.name item.user.profile.full_name
          author.email item.user.email
        end
      elsif item.user.tutor?
        entry.author do |author|
          author.name item.user.tutor.name
          author.email item.user.email
        end
      end

    end
  end
end