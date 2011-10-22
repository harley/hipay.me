class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :invoices, :dependent => :destroy

  def to_s
    email
  end

  def set_live_stripe_keys keys
    if keys
      self.live_stripe_public_key = keys[:public_key]
      self.live_stripe_private_key = keys[:private_key]
    end
  end

  def set_test_stripe_keys keys
    if keys
      self.test_stripe_public_key = keys[:public_key]
      self.test_stripe_private_key = keys[:private_key]
    end
  end
end
