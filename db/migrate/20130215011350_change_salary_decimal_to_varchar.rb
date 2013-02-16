class ChangeSalaryDecimalToVarchar < ActiveRecord::Migration
  def change
    change_column :vacancies, :salary, :string
  end
end
