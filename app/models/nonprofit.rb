class Nonprofit < ActiveRecord::Base
  validates :name, presence: true
  validates :email, presence: true

  has_many :donations
  has_many :subscriptions
  has_many :transfers

  before_create :transfer_setup

  def transfer_setup
    # Set your secret key: remember to change this to your live secret key in production
    # See your keys here https://dashboard.stripe.com/account
    Stripe.api_key = ENV["TEST_SECRET"]

    # Create a Recipient
    recipient = Stripe::Recipient.create(
      :name => self.name,
      :type => "corporation",
      :email => self.email,
      :card => self.token
    )
    self.recipient_token = recipient.id
    self.card_token = recipient.cards.data[0]["id"]
  end

end
