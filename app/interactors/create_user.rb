# app/interactors/create_user.rb
class CreateUser
    include Interactor
    delegate :employee_params, :company, to: :context
  
    def call
      employee = company.users.build(employee_params)
      employee.password = generate_dummy_password
  
      if employee.save
        context.employee = employee
        context.status = :success
      else
        context.employee = employee
        context.status = :failure
        context.fail!(error: employee.errors.full_messages.to_sentence)
      end
    end
  
    private
  
    def generate_dummy_password(length = 12)
      SecureRandom.alphanumeric(length)
    end
end
  