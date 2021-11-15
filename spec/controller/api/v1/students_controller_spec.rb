require 'rails_helper'
RSpec.describe Api::V1::StudentsController, type: :controller do
  describe "Student" do
    let(:student) { create(:student)}

    describe "GET students#show" do
      it "should show student" do
        get :show, params: { id: student}, format: :json
        expect(response.status).to eq(200)
        # Test to ensure response contains the correct email
        json_response = JSON.parse(self.response.body)
        expect(student.email).to eq(json_response['email'])
      end   
    end
  end
end
