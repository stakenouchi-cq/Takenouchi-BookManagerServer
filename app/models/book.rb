class Book < ApplicationRecord
  belongs_to :user, optional: true

  validates :name, presence: true
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :purchase_date, presence: true
  validates :image, presence: true

end
