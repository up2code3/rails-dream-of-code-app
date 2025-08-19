# frozen_string_literal: true

require 'faker'

puts 'Populating student and mentor data...'

# Create enrollments for past and current trimesters
Trimester.where("start_date < '2025-05-01'").each do |trimesters|
  # Create 10 enrollments for each of the intro courses
  intro_course = Course.find_by(trimester_id: trimesters.id,
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
  advanced_courses = Course.where.not(id: intro_course.id)
  previous_trimester = Trimester.find_by(id: trimesters.id - 1)
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

puts 'Finished populating student and mentor data'
