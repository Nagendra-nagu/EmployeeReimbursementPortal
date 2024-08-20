class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_company
    before_action :set_employee, only: [:show, :edit, :update, :destroy]
  
    def index
      @employees = @company.users.paginate(page: params[:page], per_page: 5)
    end
  
    def show
    end
  
    def new
      @employee = @company.users.build
    end
  
    def create
      @employee = @company.users.build(employee_params)
      @employee.password = 'dummypassword'
      if @employee.save
        redirect_to [@company, @employee], notice: 'Employee was successfully created.'
      else
        render :new
      end
    end
  
    def edit
    end
  
    def update
      if @employee.update(employee_params)
        redirect_to [@company, @employee], notice: 'Employee was successfully updated.'
      else
        render :edit
      end
    end
  
    def destroy
      @employee.destroy
      redirect_to company_employees_url(@company), notice: 'Employee was successfully destroyed.'
    end
  
    private
  
    def set_company
      @company = Company.find(params[:company_id])
    end
  
    def set_employee
      @employee = @company.users.find(params[:id])
    end
  
    def employee_params
      params.require(:user).permit(:fname, :lname, :email)
    end
end