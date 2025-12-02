// show how many years after the film was released the award was recorded
// usinggthe year stored on HAS_AWARD
MATCH (m:Movie)-[r:HAS_AWARD]->(aw:Award)
RETURN m.title AS movie, aw.name AS award,
       m.releaseYear AS releaseYear, r.year AS awardYear,
       (r.year - m.releaseYear) AS yearsAfterRelease
ORDER BY yearsAfterRelease ASC, movie;
