// Nodes

// Create Movie nodes
MERGE (drive:Movie {title: 'Drive'}) ON CREATE SET drive.durationMinutes = 100, drive.releaseYear=2011
MERGE (br2049:Movie {title: 'Blade Runner 2049'}) ON CREATE SET br2049.durationMinutes = 164, br2049.releaseYear = 2017
MERGE (lalaland:Movie {title: 'La La Land'}) ON CREATE SET lalaland.durationMinutes = 128, lalaland.releaseYear = 2016

// Create Person nodes
// Actor subclass of Person
MERGE (gosling:Person:Actor {name:'Ryan Gosling'}) ON CREATE SET gosling.birthYear = 1980, gosling.phone = "+1-608-266-732"
MERGE (ford:Person:Actor {name:'Harrison Ford'}) ON CREATE SET ford.birthYear = 1942, ford.phone = '+1-608-111-808'
MERGE (stone:Person:Actor {name:'Emma Stone'}) ON CREATE SET stone.birthYear = 1988, stone.phone = '+1-793-264-092'

// Director subclass of Person
MERGE (refn:Person:Director {name:'Nicolas Winding Refn'}) ON CREATE SET refn.birthYear = 1970, refn.phone = "+1-324-266-793"
MERGE (villeneuve:Person:Director {name:'Denis Villeneuve'}) ON CREATE SET villeneuve.birthYear = 1967, villeneuve.phone = '+1-853-945-839'
MERGE (chazelle:Person:Director {name:'Damien Chazelle'}) ON CREATE SET chazelle.birthYear = 1985, chazelle.phone = '+1-063-853-354'

//Create Award nodes
MERGE (cannes:Award {name: 'Best Director Award'}) ON CREATE SET cannes.prizeMoney = 10000
MERGE (oscarCinem:Award {name: 'Oscar Best Cinematography'}) ON CREATE SET oscarCinem.prizeMoney = 15000
MERGE (oscarActr:Award {name: 'Oscar Best Actress'}) ON CREATE SET oscarActr.prizeMoney = 20000

//Create ScreeningEvent nodes
MERGE (hydro:ScreeningEvent {locationName: 'Hydropark'}) ON CREATE SET hydro.startTime = datetime('2011-11-11T16:30:00')
MERGE (slovDum:ScreeningEvent {locationName: 'Slovansky dum'}) ON CREATE SET slovDum.startTime = datetime('2017-07-16T21:00:00')
MERGE (guliver:ScreeningEvent {locationName: 'Guliver'}) ON CREATE SET guliver.startTime = datetime('2016-05-27T12:15:00')


// Edges
// Acted in
MERGE (gosling)-[:ACTED_IN {role: 'The Driver'}]->(drive)
MERGE (gosling)-[:ACTED_IN {role: 'Officer K'}]->(br2049)
MERGE (ford)-[:ACTED_IN {role: 'Rick Deckard'}]->(br2049)
MERGE (stone)-[:ACTED_IN {role: 'Mia Dolan'}]->(lalaland)

// Directed
MERGE (refn)-[:DIRECTED]->(drive)
MERGE (villeneuve)-[:DIRECTED]->(br2049)
MERGE (chazelle)-[:DIRECTED]->(lalaland)

// Has Award
MERGE (drive)-[:HAS_AWARD {year: 2011}]->(cannes)
MERGE (br2049)-[:HAS_AWARD {year: 2018}]->(oscarCinem)
MERGE (lalaland)-[:HAS_AWARD {year: 2017}]->(oscarActr)

// Shows film
MERGE (hydro)-[:SHOWS_FILM]->(drive)
MERGE (slovDum)-[:SHOWS_FILM]->(br2049)
MERGE (guliver)-[:SHOWS_FILM]->(lalaland);


