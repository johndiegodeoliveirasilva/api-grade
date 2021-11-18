class Api::V1::GradesController < ApplicationController
  before_action :define_grade, only: %w[show]

  def index
    render json: Grade.all
  end

  def show
    render json: @grade
  end

  private

  def define_grade
    @grade = Grade.find(params[:id])
  end
end
