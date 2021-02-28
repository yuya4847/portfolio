class AddColumnToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :username, :string, null: false, default: ""
    add_column :users, :profile, :string
    add_column :users, :sex, :integer
  end
end