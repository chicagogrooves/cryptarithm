__ = if _? then _ else require('underscore')

class Cryptarithm
  @messages:
    addError: "Provided solution does not add up"
    reusedNumberError: "The same number can not be assigned to two letters"
    reusedLetterError: "The same letter can not be assigned two numbers"

  constructor: (@term1, @term2, @sum) ->

  solve: (solt1, solt2, solsum) -> 
      try
        @solution_map = create_map( @term1+@term2+@sum, solt1+solt2+solsum )
        assert Number(solt1) + Number(solt2) == Number(solsum), Cryptarithm.messages.addError
        @failure_reason = undefined
        @success=true
      catch err
        @failure_reason = err.message.replace /:.*/, ''
        @success=false

  create_map = (puzzle, answer) ->
    do(solxn={}) ->
      for [l,v] in __.zip(puzzle, answer)
        v = Number(v)
        prev_letter = __.invert(solxn)[v]
        if prev_letter? && prev_letter isnt l
          assert false, Cryptarithm.messages.reusedNumberError + "- can't assign #{v} to both #{prev_letter} and #{l}"
          
        prev_number = solxn[l]
        if prev_number? && prev_number isnt v
          assert false, Cryptarithm.messages.reusedLetterError + "- can't assign #{l} to both #{prev_number} and #{v}"

        solxn[l] = v
      solxn

  assert = (t,msg)->
    throw {message: msg} unless t
  
global = if exports? then exports else window
global.Cryptarithm = Cryptarithm