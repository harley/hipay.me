class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :invoices, :dependent => :destroy
  has_many :payments, :through => :invoices

  def to_s
    email
  end

  def stripe_public_key
    if live_mode?
      live_stripe_public_key
    else
      test_stripe_public_key.presence || TEST_STRIPE_PUBLIC_KEY
    end
  end

  def stripe_private_key
    if live_mode?
      live_stripe_private_key
    else
      test_stripe_private_key.presence || TEST_STRIPE_PRIVATE_KEY
    end
  end

  def live_keys_present?
    live_stripe_public_key.present? and live_stripe_private_key.present?
  end

  def using_global_test_keys?
    test_stripe_public_key.blank? || test_stripe_private_key.blank?
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
