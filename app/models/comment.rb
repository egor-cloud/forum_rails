class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :answer
  has_ancestry

  scope :all_comment_to_answer, ->(answer_id) do
    self.where("answer_id = ?", answer_id)
  end

end
