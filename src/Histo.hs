{-# LANGUAGE DeriveFunctor #-}
module Histo where

import Control.Arrow

--nmain :: IO ()
--main = do
--  putStrLn "hello world"






data Attr f a = Attr
              { attribute :: a
              , hole      :: f (Attr f a)
              }


type CVAlgebra f a = f (Attr f a) -> a

histo :: Functor f => CVAlgebra f a -> Term f -> a

histo h  = worker >>> attribute 
  where
    worker = out >>> fmap worker >>> (h &&& id) >>> mkAttr
    mkAttr (a, b) = Attr a b

data ProgressInt i = Finish
                   | I Int i
                   deriving(Eq,Ord,Functor)

newtype Term f = In { out :: f (Term f) }

n2one :: Int ->  Term ProgressInt
n2one 0 = In $ Finish  
n2one i = In $ I i $  n2one (i-1) 

fibCVAlgebra :: CVAlgebra ProgressInt Int 
fibCVAlgebra Finish = 0
fibCVAlgebra (I 1 attr) = 1
fibCVAlgebra (I 2 attr) = 1
fibCVAlgebra (I i attr) = attribute attr + (attribute .wkr. hole) attr
  where
    wkr ( I idx attr')  = attr'

solveFib i = histo fibCVAlgebra (n2one i)

solveFib' i = fib !! i
  where
    fib = 0 : 1 : zipWith(+) fib (tail fib) 
  
