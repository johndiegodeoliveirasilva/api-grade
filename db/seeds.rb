Grade.delete_all
Student.delete_all


5.times do
  time = DateTime.current + rand(10)
  grade = Grade.create! title: Faker::Games::ElderScrolls.creature,
                        time_start: time, time_end: time + 2.days
  puts "Created a new grade: #{grade.title}"
  30.times do
    student = Student.create! name: Faker::Name.name,
                              email: Faker::Internet.free_email,
                              year: Faker::Date.between(from: '1996-01-23', to: '2020-09-25').strftime('%d-%m-%Y')
    student.grades << grade
    puts "Create a new student #{student.name} registred in class #{grade.title}"
  end
end
