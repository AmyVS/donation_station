class Transfer < ActiveRecord::Base
  validates :amount, presence: true

  belongs_to :nonprofit
  before_save :convert_to_cents
  before_create :transfer_funds

  def convert_to_cents
    self.amount = self.amount * 100
  end

  def transfer_funds
    Stripe.api_key = ENV["TEST_SECRET"]

    # Create a transfer to the specified recipient
    transfer = Stripe::Transfer.create(
      :amount => self.amount
      :currency => "usd",
      :recipient => self.nonprofit.id,
      :card => self.token,
    )
  end
end
