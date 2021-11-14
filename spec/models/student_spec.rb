require 'rails_helper'

RSpec.describe Student, type: :model do
  
  context 'new Student' do
    it 'student with a valid email should be valid' do
      student = build(:student)
      expect(student).to be_valid
    end

    it 'student with invalid email should be invalid' do
      student = build(:student, :without_email)
      expect(student).not_to be_valid
    end

    it 'student with taken email should be invalid' do
      other_student = create(:student)
      student = build(:student, email: other_student.email)
      expect(student).not_to be_valid
    end
  end
end
