class Food < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  has_many :recipe_food, dependent: :destroy

  attribute :name, :string
  attribute :measurement_unit, :string
  attribute :user_id, :integer
  attribute :quantity, :integer
  attribute :price, :integer

  validates :name, presence: true
  validates :measurement_unit, presence: true
  validates :user_id, presence: true
  validates :quantity, presence: true
  validates :price, presence: true
end
