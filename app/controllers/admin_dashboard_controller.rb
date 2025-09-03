class AdminDashboardController < ApplicationController
  def index
    @current_trimester = Trimester.where("start_date <= ?", Date.today).where("end_date >= ?", Date.today).first
    @upcoming_trimester = Trimester.where("start_date > ?", Date.today).where("start_date < ?", Date.today + 6.months).order(:start_date).first
  end
end
