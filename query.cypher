// MATCH 
MATCH (a:Person {name:'Huỳnh Minh Hiếu'}) RETURN a

MATCH (a:Person)-[:ACTED_IN]->(m:Movie {title: 'ĐỒ ÁN QLTT'}) RETURN a, m

MATCH (a:Person {name:'Tom Hanks'})-[:ACTED_IN]->(m:Movie) RETURN a, m

// CREATE
CREATE (a:Person {name:'Brie Larson', born:1989}) RETURN a

CREATE (a:Movie {title:'Captain Marvel', released:2019,
tagline:'Everything begins with a (her)o.'}) RETURN a


// DELETE
MATCH (a:Person {name:'Huỳnh Minh Hiếu'}) DELETE a

MATCH (a:Movie {title:'Captain Marvel'}) DETACH DELETE a

// MERGE
MERGE (a:Person {name:'Huỳnh Minh Hiếu'})
ON CREATE SET a.born = 2004
ON MATCH SET a.point = COALESCE(a.point, 0) + 1
RETURN a


// LIST COMPREHENSION
MATCH (a:Person {name:'Brie Larson'}), (b:Movie {title:'Captain Marvel'})
MERGE (a)-[r:ACTED_IN]->(b)
SET r.roles = [x in r.roles WHERE x <> 'Captain Marvel'] + ['Captain Marvel']
RETURN a,r,b

// WHERE
MATCH (a:Person) WHERE a.name STARTS WITH 'Tom' RETURN a

MATCH (a:Movie) WHERE a.released > 1990 AND a.released < 2000 RETURN a

// VALUABLE RESULTS
MATCH (a:Person {name:'Tom Hanks'})-[:ACTED_IN]->(m)<-[:ACTED_IN]-(c) RETURN c.name

MATCH (people:Person)-[relatedTo]-(:Movie {title:'Cloud Atlas'})
RETURN people.name, type(relatedTo), relatedTo

// SOLVE
MATCH (doan:Movie {title:"ĐỒ ÁN QLTT"})-[*0..4]-(p)
RETURN DISTINCT p

MATCH p=shortestPath(
              (bacon:Person {name:"Kevin Bacon"})-[*]-(a:Person {name:'Al Pacino'})
            )
RETURN p

// RECOMMEND
MATCH (a:Person {name:'Tom Hanks'})-[:ACTED_IN]->(m)<-[:ACTED_IN]-(coActors),
      (coActors)-[:ACTED_IN]->(m2)<-[:ACTED_IN]-(cocoActors)
WHERE NOT (a)-[:ACTED_IN]->()<-[:ACTED_IN]-(cocoActors) AND a <> cocoActors
RETURN cocoActors.name AS Recommended, count(*) AS Strength ORDER BY Strength DESC

MATCH (a:Person {name:'Tom Hanks'})-[:ACTED_IN]->(m)<-[:ACTED_IN]-(coActors),
(coActors)-[:ACTED_IN]->(m2)<-[:ACTED_IN]-(other:Person {name:'Tom Cruise'})
RETURN a, m, coActors, m2, other