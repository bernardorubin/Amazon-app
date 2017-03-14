class Product < ApplicationRecord
  belongs_to :user, optional: true
  has_many :reviews, -> { order(created_at: :desc) }, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :likers, through: :likes, source: :user
  has_many :taggings, dependent: :destroy
  has_many :tags,  through: :taggings
#################Test Driven Development Tests ####################

  validates :title, {presence: true, uniqueness: true}
  validates :price, {presence: true}
  # validates :sale_price, numericality: { less_than_or_equal_to: :price}

  before_validation(:set_sale_price)
  # before_save
  validate :sale_price_not_higher

# THIS DIDN'T WORK
  # scope :product_tag, -> (tag) do
  #   where({tag_id: tag})
  # end

  def on_sale?
    if self.sale_price < self.price
      true
    else
      false
    end
  end

  def liked_by?(user)
    likes.exists?(user: user)
  end

  def like_for(user)
    likes.find_by(user: user)
  end

  private

  def set_sale_price
      self.sale_price ||= self.price
  end

  def sale_price_not_higher
    if self.price
      if self.sale_price > self.price
        errors.add(:sale_price, 'Sale Price cant be greater')
      end
    end
  end


########################## End Tests ##################




  # validates :title, {presence: true, uniqueness: {:case_sensitive => false}}
  # validates :price, presence: true, numericality: {greater_than_or_equal_to: 0}
  # validates :description, {presence: true, length: {minimum: 10}}
  #
  # before_validation(:set_price)
  # before_validation(:set_hit)
  # before_validation(:set_sale_price)
  # before_save(:capitalizer)
  #
  # validate :reserved
  # validate :sale_price_not_higher
  #
  # def self.search(query)
  #   where("title ILIKE ?", "%#{query}%") |
  #   where("description ILIKE ?", "%#{query}%")
  # end
  #
  # def add_hit
  #   # obj.hit_count += 1
  #   # self.save
  #   # update_attributes({hit_count: 1})
  # # skips validation
  #   update_column(:hit_count, hit_count + 1)
  # end
  #
  # private
  #
  # def set_price
  #     self.price ||= 1
  # end
  #
  # def set_hit
  #     self.hit_count ||= 0
  # end
  #
  # def set_sale_price
  #     self.sale_price ||= self.price
  # end
  #
  # def capitalizer
  #     self.title = title.titleize
  # end
  #
  # def reserved
  #   if title.present? && title.downcase.include?('apple')
  #     errors.add(:title, 'No Apple please!')
  #   end
  #   if title.present? && title.downcase.include?('microsoft')
  #     errors.add(:title, 'No Microsoft please!')
  #   end
  #   if title.present? && title.downcase.include?('sony')
  #     errors.add(:title, 'No Sony please!')
  #   end
  # end
  #
  # def sale_price_not_higher
  #   if self.sale_price > self.price
  #     errors.add(:sale_price, 'Sale cant be greater')
  #   end
  # end
end
