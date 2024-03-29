class CreateStudents < ActiveRecord::Migration[6.1]
  def change
    create_table :students do |t|
      t.string :name, null: false
      t.string :email, unique: true
      t.integer :year, null: false

      t.timestamps
    end
  end
end
