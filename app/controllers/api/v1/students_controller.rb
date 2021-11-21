class Api::V1::StudentsController < ApplicationController
  before_action :student, only: %w[show update destroy]

  def index
    render json: Student.all
  end

  def show
    render json: @student
  end

  # POST /students
  def create
    @student = Student.new(student_params)
    if @student.save
      render json: @student, status: :created
    else
      render json: @student.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /students/1
  def update
    if @student.update(student_params)
      render json: @student, status: :ok
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
