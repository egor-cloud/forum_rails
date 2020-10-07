class Post < ApplicationRecord
  acts_as_votable
  belongs_to :user
  belongs_to :category
  has_and_belongs_to_many :tags
  has_many :answers

  self.per_page = 15

  has_rich_text :body

  scope :posts_to_category_and_users, ->(category_id) { self.includes(:user, :category)
                                                          .where("posts.category_id = ?", category_id)
                                                          .order(created_at: :desc) }

  # scope :all_comment_to_post, ->(post_id) do
  #   self.includes(:user).joins(:comments).where("comments.post_id = ?", post_id)
  # end

  # scope :all_answers_to_post, ->(post_id) { self.includes(:user).find(post_id) }

  def all_tags
    self.tags.map(&:name).join(" ")
  end

  def all_tags=(names)
    #Исключить все символы кроме нормальных букв цифр и знаков подчеркивания
    names.downcase!
    names.gsub!(/(?=\W)[^" "]/, "")
    self.tags = names.split(" ").map do |name|
      Tag.where(name: name.strip).first_or_create!
    end
  end

end
