class CreateGrades < ActiveRecord::Migration[6.1]
  def change
    create_table :grades do |t|
      t.text :title
      t.datetime :time_start
      t.datetime :time_end
      t.belongs_to :student, null: false, foreign_key: true
      t.timestamps
    end
  end
end
