class Category < ApplicationRecord
  has_ancestry
  has_many :posts

  mount_uploader :avatar, CategoryAvatarUploader

  validate :picture_size

end
