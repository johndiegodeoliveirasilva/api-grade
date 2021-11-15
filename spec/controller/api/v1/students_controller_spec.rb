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

    describe "POST student #new" do
      it "should create student" do
        post :create, params: { student: { name: 'Teste', email: 'test@test.org', year: 20 }}, format: :json
        expect(response).to have_http_status :created
      end

      it 'should not create user with taken email' do
        post :create, params: { student: { name: 'John', email: student.email, year: 30 }}, format: :json
        expect(response).to have_http_status :unprocessable_entity
      end
    end

    describe "PATCH student #update" do
      it 'should update student' do
        patch :update, params: {id: student, student: { email: student.email}}, format: :json
        expect(response).to have_http_status :success
      end

      it 'should not update student when invalid params are sent' do
        patch :update,  params: {id: student, student: { name: 'Toto',
                                                        email: 'bad_email',
                                                        year: 12 }}, format: :json
        expect(response).to have_http_status :unprocessable_entity
      end
    end

    describe 'DELETE student' do
      it 'should destroy student' do
        delete :destroy, params: {id: student}, format: :json
        expect(response).to have_http_status :no_content
      end
    end
  end
end
