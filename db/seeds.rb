# frozen_string_literal: true

require 'faker'
# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
#
puts 'Seeding data...'

# Create coding classes
CodingClass.find_or_create_by!(title: 'Intro to Programming',
                               description: 'Learn the basics of web development, including HTML, CSS and Javascript.')
CodingClass.find_or_create_by!(title: 'React', description: 'Learn frontend web development with the React framework.')
CodingClass.find_or_create_by!(title: 'NodeJS',
                               description: 'Learn the basics of backend web development using NodeJS.')
CodingClass.find_or_create_by!(title: 'Ruby on Rails',
                               description: 'Learn the basics of Ruby and the Ruby on Rails framework.')
CodingClass.find_or_create_by!(title: 'Python', description: 'Learn the basics of Python.')

# Create trimester records for 2023, 2024, 2025
Trimester.find_or_create_by!(
  year: '2023',
  term: 'Fall',
  application_deadline: '2023-08-15',
  start_date: '2023-09-01',
  end_date: '2023-11-30'
)
Trimester.find_or_create_by!(
  year: '2024',
  term: 'Spring',
  application_deadline: '2024-02-15',
  start_date: '2024-03-01',
  end_date: '2024-05-31'
)
Trimester.find_or_create_by!(
  year: '2024',
  term: 'Summer',
  application_deadline: '2024-05-15',
  start_date: '2024-06-01',
  end_date: '2024-08-31'
)
Trimester.find_or_create_by!(
  year: '2024',
  term: 'Fall',
  application_deadline: '2024-08-15',
  start_date: '2024-09-01',
  end_date: '2024-11-30'
)
Trimester.find_or_create_by!(
  year: '2025',
  term: 'Spring',
  application_deadline: '2025-02-15',
  start_date: '2025-03-01',
  end_date: '2025-05-31'
)
Trimester.find_or_create_by!(
  year: '2025',
  term: 'Summer',
  application_deadline: '2025-05-15',
  start_date: '2025-06-01',
  end_date: '2025-08-31'
)
Trimester.find_or_create_by!(
  year: '2025',
  term: 'Fall',
  application_deadline: '2025-08-15',
  start_date: '2025-09-01',
  end_date: '2025-11-30'
)

# Create course records for each coding class and trimester
# A course is a specific instance of a coding class in a trimester. (Intro to Programming - Spring 2024, for example)
CodingClass.all.each do |coding_class|
  Trimester.all.each do |trimester|
    Course.find_or_create_by!(
      coding_class_id: coding_class.id,
      trimester_id: trimester.id,
      max_enrollment: 25
    )
  end
end

# Create lessons
Course.all.each do |course|
  (1..10).each do |lesson_number|
    Lesson.find_or_create_by!(
      course_id: course.id,
      title: "#{course.coding_class.title} - Week #{lesson_number}",
      lesson_number: lesson_number,
      assignment_due_date: course.trimester.start_date + (lesson_number * 9).days
    )
  end
end

# Create enrollments for past and current trimesters
Trimester.where("start_date < '2025-05-01'").each do |trimester|
  # Create 10 enrollments for each of the intro courses
  intro_course = Course.find_by(trimester_id: trimester.id,
                                coding_class_id: CodingClass.find_by(title: 'Intro to Programming'))

  (1..10).each do |i|
    student = Student.find_or_create_by!(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email
    )

    grade = i % 3 != 0 ? 'completed' : nil
    Enrollment.find_or_create_by!(
      course_id: intro_course.id,
      student_id: student.id,
      final_grade: grade
    )
  end

  # For advanced courses, pick from intro students from previous trimester
  advanced_courses = Course.where(trimester_id: trimester.id).where.not(id: intro_course.id)
  previous_trimester = Trimester.find_by(id: trimester.id - 1)
  next unless previous_trimester

  previous_intro_course = Course.find_by(trimester_id: previous_trimester.id,
                                         coding_class_id: CodingClass.find_by(title: 'Intro to Programming'))
  previous_intro_enrollments = Enrollment.where(course_id: previous_intro_course.id)

  previous_intro_enrollments.each_with_index do |enrollment, index|
    course_index = index % 4
    next unless advanced_courses[course_index]

    Enrollment.find_or_create_by!(
      course_id: advanced_courses[course_index].id,
      student_id: enrollment.student_id,
      final_grade: 'completed'
    )
  end
end

# Create mentors
enrollment_count = Enrollment.count
mentor_count = (enrollment_count.to_f / 3.0).ceil

(1..mentor_count).each do |_i|
  mentor = Mentor.find_or_create_by!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email
  )

  # Pick 3 enrollments without a mentor assignment
  Enrollment.left_joins(:mentor_enrollment_assignments).where(mentor_enrollment_assignments: { id: nil }).limit(3).each do |enrollment|
    MentorEnrollmentAssignment.find_or_create_by(
      mentor_id: mentor.id,
      enrollment_id: enrollment.id
    )
  end
end

puts 'End data seeding'
