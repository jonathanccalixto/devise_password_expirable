require 'devise/strategies/database_authenticatable'

module Devise
  module Models
    module PasswordExpirable
      def active_for_authentication?
        password_still_valid? && super
      end

      def password_still_valid?
        return false unless expiration_password_at

        expiration_password_at >= Time.current
      end

      def password_expired?
        !password_still_valid?
      end

      def inactive_message
        password_expired? ? :password_expired : super
      end
    end
  end
end
