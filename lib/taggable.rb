module Taggable
  attr_accessor :tags_list

  def tags_list
    taggings.map{ |tagging| tagging.tag }
  end

  def tags_list= tags
    self.tags = tags.split(',').collect{ |tag_name| Tag.find_or_create_by_name( tag_name.strip.downcase ) }
  end
end
