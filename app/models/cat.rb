class Cat < ActiveRecord::Base
  validates :name, presence: true
  validates :color, inclusion: { in: %w(white, black, calico, orange, tabby, grey)}
  validates :sex, inclusion: { in: %w(M, F)}


  def age
    self.birth_date - Time.now
  end
end
