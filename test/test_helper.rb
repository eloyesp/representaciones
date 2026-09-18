ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Logs in as a user (default: the `dev` fixture with password "password").
    def sign_in_as(user = users(:dev))
      post login_path, params: { session: { username: user.username, password: "password" } }
    end

    # Add more helper methods to be used by all tests here...
  end
end
