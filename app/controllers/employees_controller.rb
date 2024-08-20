class EmployeesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_company
    before_action :set_employee, only: [:show, :edit, :update, :destroy]
  
    def index
      @employees = @company.employees.paginate(page: params[:page], per_page: 5)
    end
  
    def show
    end
  
    def new
      @employee = @company.employees.build
    end
  
    def create
      @employee = @company.employees.build(employee_params)
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
      @employee = @company.employees.find(params[:id])
    end
  
    def employee_params
      params.require(:employee).permit(:first_name, :last_name)
    end
end
  