class User < ApplicationRecord
  #Создание виртуального атрибута
  attr_accessor :remember_token

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

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ?
             BCrypt::Engine::MIN_COST :
             BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  #Запомнить пользователя в базе создав виртуальную рандомную строку а затем записать ее дайджест в базу
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Возвращает true, если указанный токен соответствует дайджесту.
  def authenticated?(remember_token)
    return false if self.remember_digest.nil?
    BCrypt::Password.new(self.remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end
end
