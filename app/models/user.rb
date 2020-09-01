class User < ApplicationRecord

  valid_email = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  before_save do
    self.email = email.downcase
  end

  validates :login, presence: true, length: {maximum: 30}, uniqueness: true
  validates :email, presence: true, length: {maximum: 255}, uniqueness: { case_sensitive: false },
            format: { with: valid_email }

  #Добовляет метод authenticate и 2 виртуальных атрибута модели password и password_confirm и на основе
  # этих атрибутов сравнивая их по схожести делает дайджест который, можно сверить методом authenticate
  has_secure_password
  validates :password, length: {minimum: 9}, presence: true
  validates :password_confirmation, length: {minimum: 9}, presence: true
end
