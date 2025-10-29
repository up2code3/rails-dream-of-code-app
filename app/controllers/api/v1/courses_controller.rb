class Api::V1::CoursesController < ApplicationController
  def index
    # current trimester
    current_trimester = Trimester.where("start_date <= ?", Date.today)
                         .where("end_date >= ?", Date.today)
                         .first

    # courses for above stated current trimester
    courses = current_trimester.courses

    # now that we have them , format them with map in an array
    courses_array = courses.map do |course|
       {
         id: course.id,
         title: course.coding_class.title,
application_deadline: current_trimester.application_deadline,
         start_date: current_trimester.start_date,
         end_date: current_trimester.end_date
       }
     end
    render json: { courses: courses_array }
end
end
