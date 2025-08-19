# frozen_string_literal: true

json.array! @mentor_enrollment_assignments, partial: "mentor_enrollment_assignments/mentor_enrollment_assignment",
                                            as: :mentor_enrollment_assignment
