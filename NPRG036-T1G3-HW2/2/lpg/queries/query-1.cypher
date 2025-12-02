// For each director, we find the films they directed and them compute the average runtime and also display how many films the director has

MATCH (d:Person:Director)-[:DIRECTED]->(m:Movie)
RETURN d.name AS director,
       count(DISTINCT m) AS filmCount,
       round(avg(DISTINCT m.durationMinutes), 1) AS avgDuration
ORDER BY avgDuration DESC, director;
