class Book < ApplicationRecord
  belongs_to :user, optional: true

  validates :name, presence: true
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :purchase_date, presence: true
  validates :image, presence: true

  # 1つの書籍データをJSONにして返す
  def render_json
    self.as_json
  end

end
