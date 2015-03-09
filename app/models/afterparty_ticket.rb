class AfterpartyTicket < ActiveRecord::Base
  attr_accessible :price, :ticket_code

  belongs_to :user
  belongs_to :order
  belongs_to :ticket_code

  scope :with_user, -> { where.not(user: nil) }

  def cancel
    self.user = nil
    ticket_code.cancel if ticket_code.present?
    save
  end
end
