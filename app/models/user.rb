class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :prep_duties, class_name: Meal, primary_key: :name, foreign_key: :chef
  has_many :dish_duties, class_name: Meal, primary_key: :name, foreign_key: :dishwasher

  validates :name, presence: true
end