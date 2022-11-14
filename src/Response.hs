module Response where

import Lib
import Wordle

data LetterResponse = Grey | Yellow | Green

type Response = Vec5 LetterResponse

-- Take guess, answer and return pattern of grey, yellow and green boxes
respondToGuess :: WordleWord -> WordleWord -> Response
respondToGuess guess answer = ...
    where
        greenSpots :: Vec5 Bool
        greenSpots = V.zipWith (==) (getLetters guess) (getLetters answer)
