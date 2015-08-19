require 'byebug'

class CatRentalRequest < ActiveRecord::Base
  validates :status, inclusion: {in: %w(PENDING APPROVED DENIED)}
  validates :cat_id, :start_date, :end_date, :status, presence: true
  validate :cannot_have_overlapping_requests    # Custom Validation takes a singular verb

  after_initialize :set_pending

  belongs_to :cat

  def approve!
    CatRentalRequest.transaction do
      self.update!(status: "APPROVED")
      overlapping_pending_requests.update_all(status: "DENIED")
    end
  end

  def deny!
    self.status = "DENIED"
    self.save!
  end

  private

  def set_pending
    self.status ||= "PENDING"
  end

  def overlapping_requests
    CatRentalRequest
        .where('(? > start_date AND
                end_date > ? ) AND cat_id = ?',
                self.end_date,  self.start_date, self.cat_id)
  end

  def overlapping_pending_requests
    overlapping_requests.where("status = 'PENDING'")
  end

  def overlapping_approved_requests
    overlapping_requests.where("status = 'APPROVED'")
  end

  def cannot_have_overlapping_requests
    if self.status == "APPROVED" && !overlapping_approved_requests.empty?
      errors[:cat_id] << "cat is in use"
    end
  end

end
