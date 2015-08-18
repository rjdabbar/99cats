class Cat < ActiveRecord::Base
  validates :name, presence: true



  def age
    self.birth_date - Time.now
  end
end
