require 'byebug'
class Cat < ActiveRecord::Base
  CAT_COLORS = %w(white black calico orange tabby grey)
  validates :name, presence: true
  validates :color, inclusion: { in: CAT_COLORS}
  validates :sex, inclusion: { in: %w(M F)}

  has_many :rental_requests,
  foreign_key: :cat_id,
  primary_key: :id,
  class_name: "CatRentalRequest"


  def age

  #  debugger
    # self.birth_date - Time.now.strftime("%Y-%m-%d")
    ((Time.now.to_date - self.birth_date) / 365.0).round(2)

  end


end
