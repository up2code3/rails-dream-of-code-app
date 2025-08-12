
 target_trimester = Trimester.find_by(year:2025,term:"Fall")

target_courses = Course.where(trimester_id: target_trimester.id)
target_courses = Course.where(trimester_id: Trimester.find_by(year:2025,term:"Fall"))