require 'rails_helper'

RSpec.describe Grade, type: :model do
  context "Validator Grade" do
    let(:grade) { create(:grade) }
    it 'should have a future time_start' do
      expect(grade).to be_valid
    end

    it 'should not have a future time_start' do
      grade.time_start = DateTime.current - 2.day
      expect(grade).not_to be_valid
    end

    it 'should have a pass time_end' do
      expect(grade).to be_valid
    end

    it 'should not have a pass time_end' do
      grade.time_end = DateTime.current - 2.day
      expect(grade).not_to be_valid
    end
  end
end
