// find each directors' films and then sum their Prize Money and then compute the average duration of their films
MATCH (d:Person:Director)-[:DIRECTED]->(m:Movie)
OPTIONAL MATCH (m)-[:HAS_AWARD]->(aw:Award)
WITH d, collect(DISTINCT m) AS films, sum(coalesce(aw.prizeMoney,0)) AS totalPrize
WITH d, totalPrize, size(films) AS filmCount,
     round(1.0 * reduce(t=0, mm IN films | t + coalesce(mm.durationMinutes,0)) / size(films), 1) AS avgDuration
RETURN d.name AS director, filmCount, avgDuration, totalPrize
ORDER BY totalPrize DESC, avgDuration DESC, director;
