// count how many awards each movie has and sort by highest count
MATCH (m:Movie)
OPTIONAL MATCH (m)-[:HAS_AWARD]->(aw:Award)
RETURN m.title AS movie, count(DISTINCT aw) AS awardCount
ORDER BY awardCount DESC, movie;
