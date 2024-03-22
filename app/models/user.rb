class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

  has_one_attached :photo

  has_many :cars, dependent: :destroy
  has_many :posts, dependent: :destroy

  has_many :planned_routes, dependent: :destroy
  has_many :trips, through: :car

  has_many :projected_rewards, through: :planned_routes
  has_many :trips, through: :cars


  # attr_accessor :new_level
  # attr_accessor :module_shown

  # def initialize(new_level = false, module_shown = false)
  #   @new_level = new_level
  #   @module_shown = module_shown
  # end

  def level
    total_rewards / 1000
  end

  def calculate_points_to_next_level
    levels_hash = {
      "level 0"=> 0, #eg : 250 therefore point - level 0
      "level 1"=> 1000, #eg : 1150 therefore point - level 1
      "level 2"=> 2000, #eg : 2750 therefore point - level 2
      "level 3"=> 3000,
      "level 4"=> 4000,
      "level 5"=> 5000,
      "level 6"=> 6000,
      "level 7"=> 7000,
      "level 8"=> 8000,
      "level 9"=> 9000
      }

      user_rewards = total_rewards

    if user_rewards >= levels_hash["level 0"] && user_rewards <= levels_hash["level 1"]
      percentage = (user_rewards - levels_hash["level 0"]).fdiv(1000)*100
    elsif user_rewards >= levels_hash["level 1"] && user_rewards <= levels_hash["level 2"]
      percentage = (user_rewards - levels_hash["level 1"]).fdiv(1000)*100
    elsif user_rewards >= levels_hash["level 2"] && user_rewards <= levels_hash["level 3"]
      percentage = (user_rewards - levels_hash["level 2"]).fdiv(1000)*100
    elsif user_rewards >= levels_hash["level 3"] && user_rewards <= levels_hash["level 4"]
      percentage = (user_rewards - levels_hash["level 3"]).fdiv(1000)*100
    elsif user_rewards >= levels_hash["level 4"] && user_rewards <= levels_hash["level 5"]
      percentage = (user_rewards - levels_hash["level 4"]).fdiv(1000)*100
    elsif user_rewards >= levels_hash["level 5"] && user_rewards <= levels_hash["level 6"]
      percentage = (user_rewards - levels_hash["level 5"]).fdiv(1000)*100
    elsif user_rewards >= levels_hash["level 6"] && user_rewards <= levels_hash["level 7"]
      percentage = (user_rewards - levels_hash["level 6"]).fdiv(1000)*100
    elsif user_rewards >= levels_hash["level 7"] && user_rewards <= levels_hash["level 8"]
      percentage = (user_rewards - levels_hash["level 7"]).fdiv(1000)*100
    elsif user_rewards >= levels_hash["level 8"] && user_rewards <= levels_hash["level 8"]
      percentage = (user_rewards - levels_hash["level 8"]).fdiv(1000)*100
    end
  end

  def total_rewards
    (trips.joins(:car).sum(:reward_point))
  end
end
