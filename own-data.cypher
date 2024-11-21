CREATE (thuy:Person {name: "Cô Thủy"})
CREATE (hieu1:Person {name: "Huỳnh Minh Hiếu", MSSV: 22520434})
CREATE (an:Person {name: "Lê Tùng Bảo Ân", MSSV: 22520016})
CREATE (dat:Person {name: "Cao Thành Đạt", MSSV: 22520205})
CREATE (quynh:Person {name: "Bang Nguyễn Quỳnh Anh", MSSV: 22520037})
CREATE (hieu2:Person {name: "Vũ Minh Hiếu", MSSV: 22520451})
CREATE (movie:Movie {title: "ĐỒ ÁN QLTT"})

CREATE (thuy)-[:REVIEWED]->(movie)
CREATE (hieu1)-[:DIRECTED]->(movie)
CREATE (an)-[:PRODUCED]->(movie)
CREATE (quynh)-[:WROTE]->(movie)
CREATE (hieu2)-[:ACTED_IN]->(movie)
CREATE (dat)-[:ACTED_IN]->(movie)

CREATE (hieu1)-[:KNOWS]->(an)
CREATE (hieu1)-[:KNOWS]->(hieu2)
CREATE (an)-[:KNOWS]->(dat)
CREATE (dat)-[:KNOWS]->(quynh)
CREATE (quynh)-[:KNOWS]->(hieu2)
CREATE (hieu2)-[:KNOWS]->(hieu1)

CREATE (hieu1)-[:FAN]->(thuy)
RETURN thuy, hieu1, an, dat, quynh, hieu2, movie