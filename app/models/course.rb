class Course < ApplicationRecord
  belongs_to :coding_class
  belongs_to :trimester
  has_many :enrollments

  delegate :title, to: :coding_class
  
  def student_name_list
   names = []
    enrollments.each do |enrollment|
      names << "#{enrollment.student.first_name} #{enrollment.student.last_name}"
    end
   names
  end

  def student_email_list
    email = []
      enrollments.each do |enrollment|
        email << enrollment.student.email
      end
    email
  end
  
end