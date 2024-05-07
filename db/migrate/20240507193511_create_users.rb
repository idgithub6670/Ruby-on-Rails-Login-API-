class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.text :first_name
      t.text :last_name

      t.timestamps
    end
  end
end
