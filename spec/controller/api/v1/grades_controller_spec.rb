require 'rails_helper'
RSpec.describe Api::V1::GradesController, type: :controller do
  describe 'Grades' do
   let(:grade) { create(:grade) }
    describe "GET gradess#show" do

      it "should show grade" do
        get :show, params: { id: grade}, format: :json
        expect(response.status).to eq(200)
        json_response = JSON.parse(self.response.body)
        expect(grade.title).to eq(json_response['title'])
      end
      
      it 'should show grades' do
        get :index, format: :json
        expect(response.status).to eq(200)
      end
    end
  end
end
