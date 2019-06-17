class AddDisplayNameToDrinks < ActiveRecord::Migration[5.2]
  def change
    add_column :drinks, :display_name, :string
  end
end
