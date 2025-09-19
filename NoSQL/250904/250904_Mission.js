/*
1. 시나리오:
여러분들은 넷플릭스의 데이터 분석가입니다. 마케팅팀이 2010년 이후 개봉한 Action 영화를 대상으로 “관객 반응과 선호 장르”를 분석해달라고 요청했습니다. 
이를 위해 movies, users, comments 컬렉션을 활용하여 다음을 해결하세요.
2. 문제
데이터 선별
movies 컬렉션에서 2010년 이상이고, 장르에 "Action"이 포함된 영화의 title, year, genres를 조회하세요.
고객 데이터 추가
새로운 고객 "홍길동"을 users 컬렉션에 추가하세요.
이메일은 "hong@test.com", 관심 장르는 ["Action", "Comedy"]입니다.
댓글 등록 및 수정
comments 컬렉션에 "홍길동"이 "Action 영화 최고!"라는 댓글을 삽입하세요.
이후 "홍길동"의 댓글 내용을 "Action 영화 진짜 재밌다!"로 수정하세요.
장르별 인기 분석
movies 컬렉션에서 장르별 영화 수를 집계하고, 가장 많은 3개 장르를 출력하세요.
평점 기준 상위 영화
movies 컬렉션에서 평점이 8.5 이상인 영화의 title, imdb.rating, year를 출력하고, 최신 영화 순으로 정렬하세요.
 6.  사용자별 댓글 활동 분석
        comments에서 *사용자(email 기준)*별 총 댓글 수, 댓글 평균 길이를 집계하고, 총 댓글 수 내림차순 → 평균 길이 내림차순으로 정렬하여 상위 5명을 출력하세요.
*/
use sample_mflix
// 1. 데이터 선별
db.movies.find(
  {year: {$gte: 2010}, genres: {$in: ["Action"]}},
  {title: 1, year: 1, genres: 1}
)
// 2. 고객 데이터 추가
db.users.find({name: "홍길동"})
db.users.insertOne({name: "홍길동", email: "hong@test.com", password: "asdfghjklqwertyuiopzxcvbnm", favorite_genre: ["Action", "Comedy"]})
// 3. 댓글 등록 및 수정
db.comments.find({name: "홍길동"})
db.comments.insertOne(
  {name: "홍길동", email: "hong@test.com", movie_id: "573a1390f29313caabcd418c", text: "Action 영화 최고!", date: ISODate("2025-09-04")}
)
db.comments.updateOne({name: "홍길동"}, {$set: {text: "Action 영화 진짜 재밌다!"}})
//3. 장르별 인기 분석
db.movies.aggregate([
  {$unwind: "$genres"},
  {$group: {
    _id: "$genres", movieCount: {$sum: 1}
  }},
  {$sort: {movieCount: -1}},
  {$limit: 3}
])
// 4. 평점 기준 상위 영화
db.movies.aggregate([
  { $match: { "imdb.rating": { $gte: 8.5 } } },   // 조건 필터링 먼저
  {
    $group: {
      _id: "$title",
      avgRating: { $first: "$imdb.rating" },
      movieYear: { $first: "$year" }
    }
  }
])
//5. 사용자별 댓글 활동 분석
// comments에서 *사용자(email 기준)*별 총 댓글 수, 댓글 평균 길이를 집계하고, 총 댓글 수 내림차순 → 평균 길이 내림차순으로 정렬하여 상위 5명을 출력하세요
db.comments.find()
db.comments.aggregate([
  {$group: {
    _id: "$email",
    totalComments: {$sum: 1},
    avgLen: {$avg: {$strLenCP: {$toString: "$text"}}}
  }},
  {$sort: {totalComments: -1, avgLen: -1}},
  {$limit: 5}
])