require 'rails_helper'

RSpec.describe Grade, type: :model do
  context "Validator Grade" do
    it 'should have a future time_start' do
      grade = create(:grade)
      grade.time_start = DateTime.current + 2.day
      expect(grade).to be_valid
    end

    it 'should not have a future time_start' do
      grade = create(:grade)
      grade.time_start = DateTime.current - 2.day
      expect(grade).not_to be_valid
    end
  end
end
