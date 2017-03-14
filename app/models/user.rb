class User < ApplicationRecord
  has_many :products, dependent: :nullify
  has_many :reviews, dependent: :nullify
  has_many :likes, dependent: :destroy
  has_many :liked_products, through: :likes, source: :product
  before_create :create, :generate_api_key


  has_secure_password


  def self.search(query)
    where("first_name ILIKE ? OR last_name ILIKE ? OR email ILIKE ?", "%#{query}%", "%#{query}%", "%#{query}%")
  end


  before_validation :downcase_email

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  # in console -> VALID_EMAIL_REGEX.match('abc@abc.com') ->returns match data
  validates :email, presence: true, uniqueness: true, format: VALID_EMAIL_REGEX

  def full_name
    "#{first_name} #{last_name}".strip.titleize
  end

  private

  def downcase_email
    self.email&.downcase!
  end
  
  def generate_api_key
    loop do
      self.api_key = SecureRandom.hex
      break unless User.exists?(api_key: api_key)
    end
  end





end
