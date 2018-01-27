import Criterion.Main
import Histo


-- The function we're benchmarking.
fib m | m < 0     = error "negative!"
      | otherwise = go m
  where
    go 0 = 0
    go 1 = 1
    go n = go (n-1) + go (n-2)

-- Our benchmark harness.
main = defaultMain [
    bgroup "histoFib" [ bench "1"  $ whnf solveFib 1
                      , bench "5"  $ whnf solveFib 5
                      , bench "9"  $ whnf solveFib 9
                      , bench "11" $ whnf solveFib 11
                      , bench "20" $ whnf solveFib 20
                      , bench "50" $ whnf solveFib 50
                      ]
  , bgroup "sovleFib'" [ bench "1"  $ whnf solveFib' 1
                      , bench "5"  $ whnf solveFib' 5
                      , bench "9"  $ whnf solveFib' 9
                      , bench "11" $ whnf solveFib' 11
                      , bench "20" $ whnf solveFib' 20
                      , bench "50" $ whnf solveFib' 50
               ]
  , bgroup "naiveFib" [ bench "1"  $ whnf naiveFib 1
                      , bench "5"  $ whnf naiveFib 5
                      , bench "9"  $ whnf naiveFib 9
                      , bench "11" $ whnf naiveFib 11
                      , bench "20" $ whnf naiveFib 20
                      , bench "50" $ whnf naiveFib 50
               ]

  ]
