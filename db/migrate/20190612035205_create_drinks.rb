class CreateDrinks < ActiveRecord::Migration[5.2]
  def change
    create_table :drinks do |t|
      t.string :name
      t.decimal :volume_alcohol
      t.string :img_path

      t.timestamps
    end
  end
end
