-- select every student that has been in the same class occurrence
-- as an infected student in the 10 days prior to their positive test
-- SELECT * FROM
-- (
-- SELECT DISTINCT attendance.person_id as notify_covid_contact
--     FROM attendance --(4)return attendances (id) within those times and in those
--     JOIN            --classrooms (meaning same class), except who tested positive,
--         (           --to be notified as a contact and isolate + contact SNS
--         SELECT *           --(3)join all occurrences to the ones where someone that has
--         FROM occurrence     --been confirmed infected was present. This way, you have the
--         JOIN                --start and end times for classes with infected people.
--             (
--             SELECT *, classroom as sala           --(2)all attendances of people that tested positive in the 10
--             FROM attendance      --days prior to their covid exam
--             JOIN
--                 (
--                 SELECT *          --(1)returns everyone who tested positive
--                 FROM covid
--                 WHERE covid.result = 'positive'
--                 )--(1)
--             USING (person_id)
--             JOIN covid USING (person_id) 
--             WHERE attendance.swipe BETWEEN date(covid.date , '-10 days') AND covid.date
--             ) --(2)
--         ON swipe BETWEEN occurrence.start_time AND occurrence.end_time AND sala = occurrence.classroom
--         ) --(3)
--     ON attendance.swipe BETWEEN occurrence.start_time AND occurrence.end_time
-- JOIN occurrence
-- ON attendance.classroom = occurrence.classroom
-- LEFT JOIN covid USING (person_id)
-- WHERE covid.result IS NOT 'positive'
-- ) WHERE notify_covid_contact=?
-- ;



--     select distinct attendance.student_id,*
--     from        
--     (select occurrence.course,occurrence.class_number,occurrence.id, occurrence.start_time, occurrence.end_time
--         from attendance 
--             join occurrence 
--               on attendance.swipe
--               between start_time
--               and end_time
--             join covid
--               on covid.person_id = attendance.student_id
--         WHERE occurrence.classroom = attendance.classroom
--         group by occurrence.course,occurrence.class_number,occurrence.id
--         having covid.result = 'positive'
--         and start_time between date(covid.date, '-10 days') and covid.date)
--     join attendance
--       on attendance.swipe
--       between start_time
--       and end_time
--     left join covid
--       on attendance.student_id = covid.person_id
-- ;



-- -- return all the attendees for a specific class occurrence
-- SELECT DISTINCT person.id, *
--   FROM attendance
--     JOIN occurrence
--         ON attendance.swipe
--         BETWEEN start_time
--     AND end_time
--     JOIN person
--     ON attendance.student_id = person.id
-- WHERE attendance.classroom = occurrence.classroom
--   AND occurrence.course='SIBD'
--   AND occurrence.class_number='01'
--   AND occurrence.id=1   --search by occurrence id
--  -- and occurrence.start_time like '2020-09-29%'   -- search by date
--  ;

-- SELECT person.name FROM 
--     (SELECT DISTINCT person.id
--   FROM attendance
--     JOIN occurrence
--         ON attendance.swipe
--         BETWEEN start_time
--     AND end_time
--     JOIN person
--     ON attendance.student_id = person.id
-- WHERE attendance.classroom = occurrence.classroom
--   AND occurrence.course='SIBD'
--   AND occurrence.class_number='01'
--   AND occurrence.id=1)
--   INNER JOIN person using (id)
--   ;


--return all the occurrences before todays date (in the
--professor's section, so they can add new attendances)
-- SELECT *
-- FROM occurrence
-- WHERE occurrence.end_time < strftime('%Y-%m-%d %H-%M-%S','now')
-- GROUP BY course, class_number, id
-- ;

-- SELECT date(occurrence.start_time) as 'date(%dd-%m %H-%M)', person_id
--   FROM attendance
--   JOIN occurrence 
--     ON attendance.swipe BETWEEN occurrence.start_time AND occurrence.end_time AND attendance.classroom = occurrence.classroom
--  WHERE person_id = 201703602
-- ;
-- query to select all people and retrieve professor info such as 
-- "SELECT person.id as person_ide, person.name as person_name, faculty.name as faculty_name, degree.name as degree_name
-- FROM PERSON
-- LEFT JOIN ENROLLMENT ON person.id = enrollment.person_id
-- LEFT JOIN STUDENT ON person.id = student.id
-- LEFT JOIN professor ON person.id = professor.id
-- LEFT JOIN degree ON student.degree = degree.acronym
-- LEFT JOIN faculty ON professor.faculty = faculty.acronym
-- WHERE person_ide = ?"
-- ;

SELECT course, class_number, start_time
  FROM occurrence
 WHERE occurrence.professor = 656730
   AND occurrence.classroom IS NOT 'EAD';