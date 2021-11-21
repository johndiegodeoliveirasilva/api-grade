class Api::V1::GradesController < ApplicationController
  before_action :define_grade, only: %w[show update destroy]

  def index
    render json: Grade.all
  end

  def show
    render json: GradeSerializer.new(@grade).serializable_hash
  end

  def create
    @grade = Grade.new(grade_params)

    if @grade.save
      render json: GradeSerializer.new(@grade).serializable_hash
    else
      render json: { errors: @grade.errors }, status: :forbidden
    end
  end

  def update
    if @grade.update(grade_params)
      render json: GradeSerializer.new(@grade).serializable_hash
    else
      render json: @grade.errors, status: :forbidden 
    end
  end

  def destroy
    @grade.destroy
    head 204
  end

  private

  def define_grade
    @grade = Grade.find(params[:id])
  end

  def grade_params
    params.require(:grade).permit(:title, :time_start, :time_end)
  end
end
