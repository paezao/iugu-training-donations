class Donation < ActiveRecord::Base
  validates :status, inclusion: { in: ["pending", "paid"] }
  validates :invoice_id, presence: true
end
