require 'byebug'
class Cat < ActiveRecord::Base
  validates :name, presence: true
  validates :color, inclusion: { in: %w(white black calico orange tabby grey)}
  validates :sex, inclusion: { in: %w(M F)}


  def age

  #  debugger
    # self.birth_date - Time.now.strftime("%Y-%m-%d")
    ((Time.now.to_date - self.birth_date) / 365.0).round(2)

  end
end
