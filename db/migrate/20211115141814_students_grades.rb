class StudentsGrades < ActiveRecord::Migration[6.1]
  def change
    create_table :grades_students, id: false do |t|
      t.belongs_to :student
      t.belongs_to :grade
    end
  end
end
