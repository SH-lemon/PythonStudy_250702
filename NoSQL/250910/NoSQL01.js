// 1. users 문서에 commentsCount 필드를 추가하고 댓글 계수 계산
// 2. 댓글 길이를 기준으로 100자 이상 LONG COMMENT, 미만 SHORT COMMENT
// array = 배열 = list
// iterable = 반복순회가능한 자료구조
// for in => .js => 반복 순회 가능한 자료 구조를 찾아와서 내부의 값을 하나씩 빼서 연산처리 후 다시 새로운 배열로 반환해주는 문법
// $map
db.users.find()
db.comments.find()

db.users.aggregate([
  {
    $lookup: {
      from: "comments",
      localField: "email",
      foreignField: "email",
      as: "C"
    }
  },
  {
    $addFields: {
      commentCount: {$size: "$C"},
      commentAnnotated: {
        $map: {
          input: "$C",
          as: "x",
          in: {
            text: "$$x.text",
            date: "$$x.date",
            movie_id: "$$x.movie_id",
            commentType: {
              $cond: [
                {$gte: [{$strLenCP: {$ifNull: ["$$x.text", ""]}},100]},
                "LONG COMMENT",
                "SHORT COMMENT"
              ]
            }
          }
        }
      }
    }
  }
])

//3. 아래 3개의 내용을 $facet으로 연산처리 (*파이프라인의 순서와 상관없이 동시 실행)
// 1) 최신 영화 top5
// 2) 고평점 영화 개수 (*8점 이상)
// 3) 장르별 영화 분석
db.movies.aggregate([
  {
    $facet: {
      latest5: [
        { $sort: { year: -1 } },
        { $limit: 5 },
        { $project: { _id: 0, title: 1, year: 1 } }
      ],
      highRatedCount: [
        { $match: { "imdb.rating": { $gte: 8 } } },
        { $count: "Count" }
      ],
      genresByCount: [
        { $unwind: "$genres" },
        { $group: { _id: "$genres", count: { $sum: 1 } } },
        { $sort: { count: -1 } }
      ]
    }
  },
  {
    $project: {
      latest5: 1,
      highRatedCount: {
        $ifNull: [ { $arrayElemAt: ["$highRatedCount.Count", 0] }, 0 ]
      },
      genresByCount: 1
    }
  }
])