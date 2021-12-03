require 'rails_helper'
RSpec.describe Api::V1::StudentsController, type: :controller do
  describe "Student" do
    let(:student) { create(:student) do |student|
      student.grades.create(attributes_for(:grade))
    end }

    let(:students) { create_list :student, 5, name: 'Johnson'}
    describe "GET students#index" do
      it 'should show students' do
        get :index, format: :json
        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body, symbolize_names: true)
        expect(json_response.dig(:links, :first)).to be_truthy
        expect(json_response.dig(:links, :last)).to be_truthy
        expect(json_response.dig(:links, :prev)).to be_truthy
        expect(json_response.dig(:links, :next)).to be_truthy
      end

      it 'should filter students by name' do
        students
        expect(Student.filter_by_name('johnson').count).to eq(5)
      end

      it 'should filter students by email' do
        expect(Student.filter_by_email(students.first.email).count).to eq(1)
      end

      it 'should not filter students by email' do
        expect(Student.filter_by_email("#{students.first.email}ola").count).to eq(0)
      end
    end

    describe "GET students#show" do
      it "should show student" do
        get :show, params: { id: student}, format: :json
        expect(response.status).to eq(200)
        # Test to ensure response contains the correct email
        json_response = JSON.parse(self.response.body, symbolize_names: true)
        expect(student.email).to eq(json_response.dig(:data, :attributes, :email))
        expect(student.grades.first.id.to_s).to eq(json_response.dig(:data, :relationships, :grades, :data, 0, :id))
        expect(student.grades.first.title).to eq(json_response.dig(:included, 0, :attributes, :title))
      end
    end

    describe "POST student #new" do
      it "should create student" do
        post :create, params: { student: { name: 'Teste', email: 'test@test.org', year: 20 }}, format: :json
        expect(response).to have_http_status :ok
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
