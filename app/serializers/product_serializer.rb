class ProductSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :price, :sale_price, :created_on, :seller
  has_many :reviews
  has_many :tags

  def created_on
    object.created_at.strftime('%Y-%B-%d')
  end
  def seller
    u = User.find(object.user_id)
    u.first_name + ' '+ u.last_name
  end

end
