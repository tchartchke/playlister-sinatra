module Slug
  def slug
    name.downcase.gsub(' ', '-')
  end
end

module Unslug
  def find_by_slug(slug)
    all.find { |property| property.slug == slug }
  end
end

