require 'rails_helper'

RSpec.describe Student, type: :model do
  
  context 'new Student' do
    it 'student with a valid email should be valid'
      student = build(:students)
      expect(student).valid
  end
end
