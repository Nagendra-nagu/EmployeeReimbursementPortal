class ReimbursementClaimsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_company
    before_action :set_employee
    before_action :set_reimbursement_claim, only: [:show, :edit, :update, :destroy]
  
    def index
      @reimbursement_claims = @employee.reimbursement_claims.page(params[:page] || 1).per(10)
    end
  
    def show
      respond_to do |format|
        format.js { render partial: 'reimbursement_claims/partials/show' }
      end
    end
  
    def new
      @reimbursement_claim = @employee.reimbursement_claims.build
      respond_to do |format|
        format.js { render partial: 'reimbursement_claims/partials/new' }
      end
    end
  
    def create
      @reimbursement_claim = @employee.reimbursement_claims.build(reimbursement_claim_params)
      if @reimbursement_claim.save
        redirect_to [@company, @employee, @reimbursement_claim], notice: 'Reimbursement claim was successfully created.'
      else
        render :new
      end
    end
  
    def edit
      respond_to do |format|
        format.js { render partial: 'reimbursement_claims/partials/edit' }
      end
    end
  
    def update
      if @reimbursement_claim.update(reimbursement_claim_params)
        redirect_to [@company, @employee, @reimbursement_claim], notice: 'Reimbursement claim was successfully updated.'
      else
        render :edit
      end
    end
  
    def destroy
      @reimbursement_claim.destroy
      redirect_to company_employee_reimbursement_claims_url(@company, @employee), notice: 'Reimbursement claim was successfully destroyed.'
    end
  
    private
  
    def set_company
      @company = Company.find(params[:company_id])
    end
  
    def set_employee
      @employee = @company.users.find(params[:user_id])
    end
  
    def set_reimbursement_claim
      @reimbursement_claim = @employee.reimbursement_claims.find(params[:id])
    end
  
    def reimbursement_claim_params
      params.require(:reimbursement_claim).permit(:purpose, :amount, :date_of_expenditure, :receipt)
    end
end
  