

class Food < ActiveRecord::Base
has_many :orders, dependent: :destroy
has_many :parties, through: :orders
has_many :allergens, through: :food_allergens




 validates :name,
   uniqueness: {
   message: "This food item is already on the menu, please add something different."
 }







end
