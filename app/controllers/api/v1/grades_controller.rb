class Api::V1::GradesController < ApplicationController
  include Paginable
  before_action :define_grade, only: %w[show update destroy]

  def index
    @pagy, @grades = pagy(Grade.all, items: per_page)

    options = get_links_serializer_options(:api_v1_grades_path, @pagy)
    render json: GradeSerializer.new(@grades, options).serializable_hash
  end

  def show
    options = { include: [:students ] }
    render json: GradeSerializer.new(@grade, options).serializable_hash
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
