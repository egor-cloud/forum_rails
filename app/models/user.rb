class User < ApplicationRecord
  include ActiveModel::Validations
  has_many :posts
  has_many :answer, through: :posts
  has_many :comments, through: :posts

  #Создание виртуального атрибута
  attr_accessor :remember_token, :activation_token, :reset_token
  mount_uploader :avatar, AvatarUploader

  valid_email = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  before_save do
    self.email = email.downcase
  end
  #before_create - используется перед созданием модели, но не перед сохранением ее в базе как с before_save
  before_create :create_activation_digest

  validate :picture_size

  validates :login, presence: true, length: {maximum: 30}, uniqueness: true,
            format: { without: /\s/, message: "the login must not contain spaces" }

  validates :email, presence: true, length: {maximum: 255}, uniqueness: { case_sensitive: false },
            format: { with: valid_email }
  # binding.pry
  #Добовляет метод authenticate и 2 виртуальных атрибута модели password и password_confirm и на основе
  # этих атрибутов сравнивая их по схожести делает дайджест который, можно сверить методом authenticate
  has_secure_password
  validates :password, length: {minimum: 9}, presence: true, on: :create
  validates :password_confirmation, length: {minimum: 9}, presence: true, on: create

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
  # Здесь использован хак, в зависимости от того где вызван метод он будет отвечать по разному
  def authenticated?(attribute, token)
    digest = self.send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  # Устанавливает атрибуты для сброса пароля.
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest, User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  def password_reset_expired?
    #если прошло 2 часа то недействительна
    reset_sent_at < 2.hours.ago
  end

  private

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end

end
