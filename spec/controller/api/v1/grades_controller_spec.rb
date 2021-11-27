require 'rails_helper'
RSpec.describe Api::V1::GradesController, type: :controller do
  describe 'Grades' do
   let(:grade) { create(:grade) }
    describe "GET gradess#show" do

      it "should show grade" do
        students = create(:student)
        grade.students << students
        get :show, params: { id: grade}, format: :json
        expect(response.status).to eq(200)
        json_response = JSON.parse(self.response.body, symbolize_names: true)
        expect(grade.title).to eq(json_response.dig(:data, :attributes, :title))
        expect(grade.students.first.id.to_s).to eq(json_response.dig(:data, 
                                                  :relationships, :students, :data, 0, :id))
        expect(grade.students.first.email).to eq(json_response.dig(:included, 0, :attributes, :email))
      end
      
      it 'should show grades' do
        get :index, format: :json
        expect(response.status).to eq(200)
      end
    end

    describe 'POST grade#create' do
      it 'should create grade' do
        post :create, params: { grade: { title: grade.title, time_start: grade.time_start,
                                         time_end: grade.time_end } }, format: :json
        expect(response).to have_http_status(:ok)
      end

      it 'should forbid create grade' do
        post :create, params: { grade: { title: nil, time_start: grade.time_start,
                                         time_end: grade.time_end } }, format: :json
        expect(response).to have_http_status(:forbidden)
      end
    end

    describe 'PUT grade#update' do
      it 'should update grade' do
        patch :update, params: { id: grade.id, grade: { title: grade.title} }, format: :json
        expect(response).to have_http_status(:success)
      end
      it 'should forbid update grade' do
        patch :update, params: { id: grade.id, grade: { title: nil}}, format: :json
        expect(response).to have_http_status(:forbidden)
      end
    end

    describe 'DELETE grade#delete' do
      it 'should delete grade' do
        delete :destroy, params: { id: grade }, format: :json
        expect(response).to have_http_status(:no_content)
        expect(Grade.count).to eq(0)
      end
    end
  end
end
