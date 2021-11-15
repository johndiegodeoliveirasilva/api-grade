class Api::V1::StudentsController < ApplicationController
  before_action :student
  def show
    render json: @student
  end
  
  private
  def student
    @student = Student.find params[:id]
  end
end
