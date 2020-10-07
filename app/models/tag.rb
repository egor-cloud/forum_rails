class Tag < ApplicationRecord
  has_and_belongs_to_many :posts

  #Данная нотация говорит о том что нужно загрузить все посты и пользователя который создал эти посты для тегов
  #Разницы в том скоуп это или метод класса нету
  def self.users_and_their_posts
    includes(posts: [:user, :category])
  end

  # scope :counts, ->(){ Tag.select("id, name, count(posts_tags.tag_id) as count")
  #                         .joins(:posts_tags).group("posts_tags.tag_id") }

end
