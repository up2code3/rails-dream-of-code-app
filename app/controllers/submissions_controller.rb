# frozen_string_literal: true

class SubmissionsController < ApplicationController
  before_action :require_student, only: [:new, :create]
  before_action :require_mentor,  only: [:edit, :update]
  # GET /submissions/new
  def new
    @course = Course.find(params[:course_id])
    @submission = Submission.new
    @lessons = @course.lessons
    @enrollments = @course.enrollments
  end

  def create
    @course = Course.find(params[:course_id])
    @submission = Submission.new(submission_params)

    if @submission.save
      redirect_to course_path(@course), notice: "Submission was successfully created."
    else
      # 👇 reset these so the form has data
      @lessons = @course.lessons
      @enrollments = @course.enrollments
      render :new, status: :unprocessable_entity
    end
  end

  # GET /submissions/1/edit
  def edit
    @course = Course.find(params[:course_id])
    @submission = Submission.find(params[:id])
  end

  # PATCH/PUT /submissions/1 or /submissions/1.json
  def update
    @course = Course.find(params[:course_id])
    @submission = Submission.find(params[:id])

    if @submission.update(submission_params)
      redirect_to course_path(@course), notice: "Submission was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

    # Only allow a list of trusted parameters through.
    def submission_params
      params.require(:submission).permit(:lesson_id, :enrollment_id, :mentor_id, :review_result, :reviewed_at)
    end
end
