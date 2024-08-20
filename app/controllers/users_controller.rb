class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_company
    before_action :set_employee, only: [:show, :edit, :update, :destroy]
  
    def index
      @employees = @company.users.page(params[:page] || 1).per(10)
    end
  
    def show
      respond_to do |format|
        format.js { render partial: 'users/partials/show' }
      end
    end
  
    def new
      @employee = @company.users.build
      respond_to do |format|
        format.js { render partial: 'users/partials/new' }
      end
    end
  
    def create
      result = CreateUser.call(employee_params: employee_params, company: @company)
      @employee = result.employee
      if result.status == :success
        redirect_to [@company, @employee], notice: 'Employee was successfully created.'
      else
        flash[:alert] = result.error
        render :new
      end
    end
  
    def edit
      respond_to do |format|
        format.js { render partial: 'users/partials/edit' }
      end
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