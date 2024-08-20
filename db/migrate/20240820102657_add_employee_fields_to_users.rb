class AddEmployeeFieldsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :employee_id, :integer
    add_column :users, :company_id, :integer
  end
end
