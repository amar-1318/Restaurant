class RestaurantDetail < ApplicationRecord
  belongs_to :user
  has_many :menus
  has_one :city
  validates :user_id, uniqueness:{message: "Owner Already have an account!"}
  validates :name, uniqueness:true

  before_create :log_creation
  before_update :log_update
  before_destroy :log_deletion

  def max_avg_rating
    restaurants = []
    restaurant_5_Stars = Menu.group(:restaurant_detail_id).where('rating =?',5).count
    restaurant_5_Stars.each{|key,val|
    if val > 0.5 * Menu.where(restaurant_detail_id:key).count  
        restaurants.push([id:key,name:RestaurantDetail.find(key).name,max_star_count:val])
    end
    }    
    return restaurants
  end

  private 
  def log_creation
    Rails.logger.info("Restaurant #{name} created! at #{created_at}")
  end

  def log_update
    Rails.logger.info("Restaurant #{name} updated at #{updated_at}")
  end

  def log_deletion
    Rails.logger.info("Restaurant #{name} is deleted")
  end
end

