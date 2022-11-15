module Response where

import qualified Data.Set as Set
import qualified Data.Vector as Vector
import Lib
import Wordle

data LetterResponse = Grey | Yellow | Green

instance Show LetterResponse where
  show Grey = "X"
  show Yellow = "Y"
  show Green = "G"

getResponses :: Response -> Vec5 LetterResponse
getResponses (MkResponse rs) = rs

newtype Response = MkResponse (Vec5 LetterResponse)

instance Show Response where
  show (MkResponse responses) = concatMap show (Vector.toList responses)

-- Take guess, answer and return pattern of grey, yellow and green boxes
respondToGuess :: WordleWord -> WordleWord -> Response
respondToGuess guess answer = MkResponse (Vector.zipWith convert greenSpots (getLetters guess))
  where
    answerLetters = lettersInWord answer
    greenSpots :: Vec5 Bool
    greenSpots = Vector.zipWith (==) (getLetters guess) (getLetters answer)

    convert :: Bool -> Char -> LetterResponse
    convert False theLetter
      | theLetter `Set.member` answerLetters = Yellow
      | otherwise = Grey
    convert True _ = Green
