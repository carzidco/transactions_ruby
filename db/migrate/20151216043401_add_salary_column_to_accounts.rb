class AddSalaryColumnToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :salary, :float
  end
end
