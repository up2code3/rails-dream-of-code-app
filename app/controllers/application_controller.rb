# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def require_admin
    if session[:role] != "admin"
      flash[:alert] = "You do not have access to that page"
      redirect_to root_path
    end
  end

  def require_student
    if session[:role] != "student"
      flash[:alert] = "You do not have access to that page"
      redirect_to root_path
    end
  end

  def require_mentor
    if session[:role] != "mentor"
      flash[:alert] = "You do not have access to that page"
      redirect_to root_path
    end
  end
end
