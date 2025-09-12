class TrimestersController < ApplicationController
  def index
    @trimesters = Trimester.all
  end

  def show
    @trimester = Trimester.find(params[:id])
  end

  def edit
    @trimester = Trimester.find(params[:id])
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

  def trimester_params
    params.require(:trimester).permit(:application_deadline)
  end
end
