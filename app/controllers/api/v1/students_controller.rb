class Api::V1::StudentsController < ApplicationController
  include Paginable
  before_action :student, only: %w[show update destroy]

  def index
    @pagy, @students = pagy(Student.all, items: per_page)
    options = get_links_serializer_options(:api_v1_students_path, @pagy)
    render json: StudentSerializer.new(@studens, options).serializable_hash
  end

  def show
    options = { include: [:grades ] }
    render json: StudentSerializer.new(@student, options).serializable_hash
  end

  # POST /students
  def create
    @student = Student.new(student_params)
    if @student.save
      render json: StudentSerializer.new(@student).serializable_hash
    else
      render json: @student.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /students/1
  def update
    if @student.update(student_params)
      render json: StudentSerializer.new(@student).serializable_hash
    else
      render json: @student.errors, status: :unprocessable_entity
    end
  end

  # DELETE /students/1
  def destroy
    @student.destroy
    head 204
  end

  private
  def student
    @student = Student.find params[:id]
  end

  def student_params
    params.require(:student).permit(:email, :name, :year)
  end
end
