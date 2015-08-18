require 'byebug'

class CatRentalRequest < ActiveRecord::Base
  validates :status, inclusion: {in: %w(PENDING APPROVED DENIED)}
  validates :cat_id, :start_date, :end_date, :status, presence: true
  validate :overlapping_approved_requests    # Custom Validation takes a singular verb

  after_initialize :set_pending

  belongs_to :cat



  private

  def set_pending
    self.status ||= "PENDING"
  end

  def overlapping_requests
    CatRentalRequest.where("status = 'APPROVED' AND cat_id = #{self.cat_id}")
  end

  def overlapping_approved_requests
    if self.status == "APPROVED"
      overlapping_requests.each do |approved_request|

        if approved_request.end_date > self.start_date ||
            self.end_date.between?(approved_request.start_date, request.end_date)
            errors[:start_date] << "this cat is already in use"
        end
      end
    end
  end


end
