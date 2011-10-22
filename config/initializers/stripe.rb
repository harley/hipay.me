config_file = File.join(Rails.root, "config", "keys", "stripe.yml")
config = File.exists?(config_file) ? YAML.load_file(config_file) : {}
TEST_STRIPE_PRIVATE_KEY = ENV['TEST_STRIPE_PRIVATE_KEY'] || config['test_stripe_private_key'] || (raise "Need Stripe private key")
TEST_STRIPE_PUBLIC_KEY = ENV['TEST_STRIPE_PUBLIC_KEY'] || config['test_stripe_public_key'] || (raise "Need Stripe public key")

