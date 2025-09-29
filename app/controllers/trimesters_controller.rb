class TrimestersController < ApplicationController
  before_action :require_admin, only: [:new, :create, :edit, :update, :destroy]

  def index
    @trimesters = Trimester.all
  end

  def new
    @trimester = Trimester.new
  end

  def show
    @trimester = Trimester.find(params[:id])
  end

  def edit
    @trimester = Trimester.find(params[:id])
  end

  def create
    @trimester = Trimester.new(trimester_params)

    if @trimester.save
      redirect_to @trimester, notice: "Trimester created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @trimester = Trimester.find(params[:id])

    if @trimester.update(trimester_params)
      redirect_to @trimester, notice: "Application deadline updated successfully."
    else
      render :edit, status: :bad_request
    end
      rescue ActiveRecord::RecordNotFound
        head :not_found
  end

  def destroy
    @trimester = Trimester.find(params[:id])
    @trimester.destroy
    redirect_to trimesters_path, notice: "Trimester deleted successfully."
  end

def trimester_params
  params.require(:trimester).permit(:year, :term, :application_deadline, :start_date, :end_date)
end
end
