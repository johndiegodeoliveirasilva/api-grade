class Api::V1::StudentsController < ApplicationController
  before_action :student, only: %w[show]

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

  private
  def student
    @student = Student.find params[:id]
  end

  def student_params
    params.require(:student).permit(:email, :name, :year)
  end
end
