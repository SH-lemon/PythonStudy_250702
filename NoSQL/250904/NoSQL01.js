db.movies.find()

db.movies.aggregate(
  [
    {$match: {year: 1995}}
  ]
)

db.comments.aggregate(
[
  {
    $group: {
        _id: "$movie_id",
        commentCount: {$sum:1}
    }
  },
  {
      $project : {
        year: "$_id",
        commentCount: 1,
        _id: 0
      }
  }
]
)

db.movies.aggregate([
{
  $group: {
    _id: "$year",
    runtime: {$avg: "$runtime"}
  }
}
])

db.movies.find().limit(2)

db.movies.aggregate([
  {
    $group: {
      _id: "$year",
      minRating : {$min: "$imdb.rating"},
      maxRating: {$max: "$imdb.rating"}
//      averageRating: {$avg: "$imdb.rating"}
    }
  }
])

db.movies.aggregate([
  {
    $group: {
      _id: "$year",
      titles: {$push: "$title"}
    }
  }
])

db.movies.aggregate([
  {
    $addFields: {
      ratingNum: {
        $convert: {
          input: "$imdb.rating",
          to: "double",
          onError: null,
          onNull: null
        }
      }
    }
  },
  {
    $group: {
        _id: "$year",
        minRating: {$min: "$ratingNum"},
        maxRating: {$max: "$ratingNum"}
    }
  }
])

db.movies.find()

db.movies.aggregate([
  {
    $group: {
      _id: "$year",
      directors: {$addToSet: "$directors"}
    }
  }
])
// addToSet: 동일한 중복값을 제거하고 하나로 가져오는 역할
// 동일한 값을 가지고 있었을 경우, 한 번만 출력

db.movies.aggregate([
  {
    $group: {
      _id: "$year",
      genres : {$addToSet: "$genres"}
    }
  }
])

db.movies.aggregate([
  {
    $group: {
      _id: "$year",
      firstMovie: { $first: "$title" },
      lastMovie: { $last: "$title" }
    }
  }
])

db.movies.aggregate([
  {
    $group: {
      _id : "$year",
      avgTitleLength: {$avg : {$strLenCP : {$toString: "$title"}}}
    }
  }
])

db.movies.aggregate([
  {$match: {year: {$gte: 2000}}},
  {$count: "movies_since_2000"}
])

db.movies.aggregate([
  {$sort: {"year": 1, "title": 1}},
  {$limit: 10}
])

db.movies.aggregate([
  {$unwind: "$genres"},
  {
    $group: {
      _id: "$year",
      genres: {$addToSet: "$genres"}
    }
  }
])

db.movies.aggregate([
  {$sort: {"imdb.rating": 1}},
  {$limit: 5}
])

// 1. 2000년 이후로 제작된 (*year) 영화의 수는 몇 개인가요?
db.movies.aggregate([
  {$match: {year: {$gte: 2000}}},
  {$count: "movies_since_2000"}
])

// 2. 각 연도별로 출시된 영화의 개수는 얼마일까요?
db.movies.aggregate([
  {
    $group: {
      _id: "$year",
      movieCount: { $sum: 1 }
    }
  }
])

// 3. 가장 많은 영화가 출시된 연도는 언제일까?
db.movies.aggregate([
  {
    $group: {
      _id: "$year",
      movieCount: {$sum: 1}
    }
  },
  {$sort: {"movieCount": -1}},
  {$limit: 1}
])

// 4. 각 연도별 평균 영화 러닝타임은 어떻게 될까요?
db.movies.aggregate([
  {
    $group: {
      _id: "$year",
      avgRunningTime: {$avg: "$runtime"}
    }
  },
  {$sort: {avgRunningTime: -1}}
])

// 5. 가장 러닝타임이 긴 영화는 어떤 영화인가요?
db.movies.aggregate([
  { $project: { title: 1, runtime: 1, _id: 0 } },
  { $sort: { runtime: -1 } },
  { $limit: 1 }
])

db.movies.aggregate([
  {$sort: {runtime: -1}},
  {$limit: 1}
])
db.movies.find().limit(1)

// 6. 각 영화 장르별 평균 평점은 어떻게 될까요?
db.movies.aggregate([
  {$unwind: "$genres"},
  {
    $group: {
      _id: "$genres",
      avgRating: { $avg: "$imdb.rating" }
    }
  },
  {$sort: {avgRating: 1}}
])

// 7. 각 연도별 영화 제목의 평균 길이를 구해주세요.
db.movies.aggregate([
  {$group: {
    _id: "$year",
    avgTitleLength: {$avg: {$strLenCP: {$toString: "$title"}}}
  }}
])

//8. 각 연도별 가장 먼저 출시된 영화의 제목은 무엇인가요?
db.movies.aggregate([
  {$sort: {"year": 1, "released": 1}},
  {$group: {
    _id: "$year",
    firstmovie: {$first: "$title"}
  }}
])

// 9. 각 연도별 개봉된 영화의 장르들을 출력해주세요.
db.movies.aggregate([
  {$unwind: "$genres"},
  {$group: {
    _id: "$year",
    movieGenre: {$addToSet: "$genres"}
  }},
  {$sort: {_id: 1}}
])