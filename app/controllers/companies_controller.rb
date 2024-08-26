class CompaniesController < ApplicationController
    before_action :set_company, only: [:show, :edit, :update, :destroy]
  
    def index
      @companies = Company.page(params[:page] || 1).per(10)
    end
  
    def show
      @users = @company.users.page(params[:page] || 1).per(10)
    end
  
    def new
      @company = Company.new
      respond_to do |format|
        format.js { render partial: 'companies/partials/new' }
      end
    end
  
    def create
      @company = Company.new(company_params)
      if @company.save
        redirect_to @company, notice: 'Company was successfully created.'
      else
        respond_to do |format|
          format.js { render partial: 'companies/partials/new' }
        end
      end
    end
  
    def edit
      respond_to do |format|
        format.js { render partial: 'companies/partials/edit' }
      end
    end

    def open_model
      @some_data = User.last
      respond_to do |format|
        format.js { render partial: 'companies/partials/test' }
      end
    end
  
    def update
      if @company.update(company_params)
        redirect_to @company, notice: 'Company was successfully updated.'
      else
        render :edit
      end
    end
  
    def destroy
      @company.destroy
      redirect_to companies_url, notice: 'Company was successfully destroyed.'
    end
  
    private
  
    def set_company
      @company = Company.find(params[:id])
    end
  
    def company_params
      params.require(:company).permit(:name)
    end
end
  