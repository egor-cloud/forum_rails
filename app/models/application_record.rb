class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def picture_size
    if self.avatar.size > 5.megabytes
      errors.add(:avatar, "should be less than 5MB")
    end
  end
end

