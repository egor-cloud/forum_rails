class Answer < ApplicationRecord
  acts_as_votable

  belongs_to :user
  belongs_to :post
  has_many :comments, dependent: :destroy

  has_rich_text :body

  validates_uniqueness_of :user_id, :scope => :post_id

  # scope :paginate_comment, ->(answer_id) { self.where("id = ?", answer_id) }

end
