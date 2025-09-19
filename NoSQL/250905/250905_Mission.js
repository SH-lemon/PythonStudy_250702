// 1. 각 사용자 문서에 commentsCount 필드를 추가하여 댓글 개수를 계산하세요.
db.users.aggregate([
  {
    $lookup: {
      from: "comments",
      localField: "email",
      foreignField: "email",
      as : "userComments"
    }
  },
  {
    $addFields: {
      commentsCount: {$size: "$userComments"}
    }
  },
  {$sort: {commentsCount: -1}},
  {$project: {_id: "$name", email: 1, commentsCount: 1}}
])
db.users.find()

/*
2. 댓글(text) 길이를 기준으로
100자 이상 → "LONG COMMENT"
100자 미만 → "SHORT COMMENT"
          라는 새 필드(commentType)를 $cond로 추가하세요.
*/
db.comments.aggregate ([
  {
    $addFields: {
      commentType: {$cond:
        {
          if: {$gte: [{ $strLenCP: "$text" },100]},
          then: "LONG COMMENT",
          else: "SHORT COMMENT"
        }
      }
    }
  }
])

/* 3. 
하나의 $facet으로 다음을 동시에 분석하세요.
최신 영화 TOP 5: year 내림차순 정렬 후 상위 5개
고평점 영화 개수: imdb.rating >= 8인 영화 수
장르별 영화 분포: genres를 $unwind 후 장르별 영화 수 집계
*/

db.movies.aggregate([
  {
    $facet: {
      top5RecentMovies: [
        { $sort: { year: -1 } },
        { $limit: 5 }
      ],
      highRatingMovieCount: [
        { $match: { "imdb.rating": { $gte: 8 } } },
        { $count: "movieCount" }
      ],
      genreMovie: [
        { $unwind: "$genres" },
        { $group: { _id: "$genres", countings: { $sum: 1 } } }
      ]
    }
  }
])