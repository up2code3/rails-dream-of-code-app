# frozen_string_literal: true

class CodingClassesController < ApplicationController
  before_action :set_coding_class, only: %i[show edit update destroy]

  # GET /coding_classes or /coding_classes.json
  def index
    @coding_classes = CodingClass.all
  end

  # GET /coding_classes/1 or /coding_classes/1.json
  def show; end

  # GET /coding_classes/new
  def new
    @course = Course.new
    @coding_class = CodingClass.new
    
end

  # GET /coding_classes/1/edit
  def edit; end

  # POST /coding_classes or /coding_classes.json
  def create
    @coding_class = CodingClass.new(coding_class_params)

    respond_to do |format|
      if @coding_class.save
        format.html { redirect_to @coding_class, notice: "Coding class was successfully created." }
        format.json { render :show, status: :created, location: @coding_class }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @coding_class.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /coding_classes/1 or /coding_classes/1.json
  def update
    respond_to do |format|
      if @coding_class.update(coding_class_params)
        format.html { redirect_to @coding_class, notice: "Coding class was successfully updated." }
        format.json { render :show, status: :ok, location: @coding_class }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @coding_class.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coding_classes/1 or /coding_classes/1.json
  def destroy
    @coding_class.destroy!

    respond_to do |format|
      format.html do
        redirect_to coding_classes_path, status: :see_other, notice: "Coding class was successfully destroyed."
      end
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_coding_class
      @coding_class = CodingClass.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def coding_class_params
      params.expect(coding_class: %i[title description])
    end
end
