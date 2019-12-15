module Services
  module Users
    class SignUp
      attr_reader :errors, :new_user

      def initialize(email:, password:)
        @errors = []
        @form = Schemas::Api::V1::CreateRegistration.new.call(email: email, password: password)
      end

      def call
        @errors = @form.errors.to_h
        return unless @form.errors.empty?

        @new_user = User.new(@form.to_h)
        return true if @new_user.save

        @errors = new_user.errors.messages
        false
      end
    end
  end
end
