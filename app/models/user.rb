class User < ApplicationRecord
  def self.search(query)
    where("first_name ILIKE ? OR last_name ILIKE ? OR email ILIKE ?", "%#{query}%", "%#{query}%", "%#{query}%")
  end
end
