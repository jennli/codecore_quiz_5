class Auction < ActiveRecord::Base
  include AASM
  belongs_to :user
  has_many :bids, dependent: :destroy

  validates :title, presence:true
  validates :end_date, presence:true
  validate :end_date_cannot_be_in_the_past

  def end_date_cannot_be_in_the_past
    if end_date.present? && end_date < Date.today
      errors.add(:end_date, "can't be in the past")
    end
  end

  def max_bid
    bids.size > 1 ? bids.order("amount DESC").first.amount : 0
  end

  # setting the whiny_transitions: false option makes it so that it won't
  # throw an exception when an invalid transition happen
  # draft / published / reserve met / won / canceled / reserve not met.

  aasm whiny_transitions: false do
    state :draft, initial: true
    state :published
    state :reserve_met
    state :won
    state :canceled
    state :reserve_not_met

    event :publish do
      transitions from: :draft, to: :published
    end

    event :cancel do
      transitions from: [:draft, :published, :reserve_met], to: :canceled
    end

    event :reserve_met do
      transitions from: :published, to: :reserve_met
    end

    event :won do
      transitions from: :reserve_met, to: :won
    end

    event :reserve_not_met do
      transitions from: :published, to: :reserve_not_met
    end
  end

end
