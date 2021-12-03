require 'rails_helper'
RSpec.describe Api::V1::GradesController, type: :controller do
  describe 'Grades' do
    let(:grade) { create(:grade) do |grade|
      grade.students.create(attributes_for(:student))
    end }
  

    let(:grades) { create_list :grade, 2, title: 'TV'}
    describe "GET gradess#show" do

      it "should show grade" do
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
        json_response = JSON.parse(response.body, symbolize_names: true)
        expect(json_response.dig(:links, :first)).to be_truthy
        expect(json_response.dig(:links, :last)).to be_truthy
        expect(json_response.dig(:links, :prev)).to be_truthy
        expect(json_response.dig(:links, :next)).to be_truthy
      end

      it 'should filter grades by title' do
        grades
        expect(Grade.filter_by_title('tv').count).to eq(2)
      end

      it 'should filter grades by title and sort them' do
        grades
        expect(Grade.filter_by_title('tv').sort).to eq([Grade.first, Grade.last])
      end

      it 'should filter grades by time_start' do
        grades
        expect(Grade.filter_by_date(Date.current.beginning_of_day,  Date.current.end_of_day).count).to eq(2)
      end

      it 'should not filter grades by time_start' do
        grades
        expect(Grade.filter_by_date('2021-11-27 00:00:00', '2021-11-27 23:59:59').count).to eq(0)
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
