class State < ApplicationRecord
  has_many :cities

  validates :name, presence: { message: "cannot be empty" }, uniqueness: true

  after_create :log_creation
  before_update :log_update
  before_destroy :log_deletion

  private

  def log_creation
    Rails.logger.info("State #{name} created! at #{created_at}")
  end

  def log_update
    Rails.logger.info("State #{name} updated at #{updated_at}")
  end

  def log_deletion
    Rails.logger.info("State #{name} is deleted")
  end
end
