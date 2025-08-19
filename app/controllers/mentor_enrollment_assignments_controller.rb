# frozen_string_literal: true

class MentorEnrollmentAssignmentsController < ApplicationController
  before_action :set_mentor_enrollment_assignment, only: %i[show edit update destroy]

  # GET /mentor_enrollment_assignments or /mentor_enrollment_assignments.json
  def index
    @mentor_enrollment_assignments = MentorEnrollmentAssignment.all
  end

  # GET /mentor_enrollment_assignments/1 or /mentor_enrollment_assignments/1.json
  def show; end

  # GET /mentor_enrollment_assignments/new
  def new
    @mentor_enrollment_assignment = MentorEnrollmentAssignment.new
  end

  # GET /mentor_enrollment_assignments/1/edit
  def edit; end

  # POST /mentor_enrollment_assignments or /mentor_enrollment_assignments.json
  def create
    @mentor_enrollment_assignment = MentorEnrollmentAssignment.new(mentor_enrollment_assignment_params)

    respond_to do |format|
      if @mentor_enrollment_assignment.save
        format.html do
          redirect_to @mentor_enrollment_assignment, notice: "Mentor enrollment assignment was successfully created."
        end
        format.json { render :show, status: :created, location: @mentor_enrollment_assignment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @mentor_enrollment_assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mentor_enrollment_assignments/1 or /mentor_enrollment_assignments/1.json
  def update
    respond_to do |format|
      if @mentor_enrollment_assignment.update(mentor_enrollment_assignment_params)
        format.html do
          redirect_to @mentor_enrollment_assignment, notice: "Mentor enrollment assignment was successfully updated."
        end
        format.json { render :show, status: :ok, location: @mentor_enrollment_assignment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @mentor_enrollment_assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mentor_enrollment_assignments/1 or /mentor_enrollment_assignments/1.json
  def destroy
    @mentor_enrollment_assignment.destroy!

    respond_to do |format|
      format.html do
        redirect_to mentor_enrollment_assignments_path, status: :see_other,
                                                        notice: "Mentor enrollment assignment was successfully destroyed."
      end
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_mentor_enrollment_assignment
      @mentor_enrollment_assignment = MentorEnrollmentAssignment.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def mentor_enrollment_assignment_params
      params.expect(mentor_enrollment_assignment: %i[mentor_id enrollment_id])
    end
end
