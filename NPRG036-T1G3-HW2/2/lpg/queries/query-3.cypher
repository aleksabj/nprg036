// for each movie,  we list its actors in a in the role they were cast as and count their total roles.
MATCH (a:Person:Actor)-[r:ACTED_IN]->(m:Movie)
RETURN m.title AS movie,
       collect(a.name + ' as ' + coalesce(r.role,'(unknown role)')) AS castList,
       count(*) AS actorCount
ORDER BY actorCount DESC, movie;
