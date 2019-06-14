class CreateUserDefines < ActiveRecord::Migration[5.2]
  def change
    create_table :user_defines do |t|
      t.references :user, foreign_key: true
      t.string :name, null:false, default: ''
      t.string :drink_id, null:false, array:true, default: []
      t.string :ratio, null:false, array:true, default: []
      t.string :ingredient_volume_alcohol, null:false, array:true, default: []

      t.timestamps
    end
  end
end
