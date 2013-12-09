chai = require 'chai'
#chai.Assertion.includeStack = true
expect = chai.expect

{Cryptarithm} = require '../src/cryptarithm.coffee'

describe 'Cryptarithm', ->
  p = new Cryptarithm "ONE", "ONE", "TWO"
  dj = new Cryptarithm "DEAN", "JESS", "LOVE"
  
  it 'should be creatable', ->
    expect(p).to.exist

  it 'should remember its terms', ->
    expect(p.term1).to.equal("ONE")
    expect(p.term2).to.equal("ONE")
    expect(p.sum).to.equal("TWO")
    
  it 'fails a solution if it maps the same number to two letters', ->
    dj.solve("1111", "2222", "3333")
    expect(dj.success).to.beFalse
    expect(dj.failure_reason).to.include Cryptarithm.messages.reusedNumberError

  it 'fails a solution if it maps the same letter to two numbers', ->
    dj.solve("6542", "1302", "7844")
    expect(dj.success).to.beFalse
    expect(dj.failure_reason).to.include Cryptarithm.messages.reusedLetterError

  it 'fails a solution if the terms dont add to each other', ->
    s = new Cryptarithm "A", "B", "C"
    s.solve("1", "2", "4")
    expect(s.success).to.beFalse
    expect(s.failure_reason).to.include(Cryptarithm.messages.addError)
    

  it 'passes a solution if no problems found', ->
    dj.solve("6542", "1533", "8075")
    expect(dj.success).to.beTrue
    map = 
      "D": 6, "E": 5, "A": 4, "N": 2
      "J": 1, "S": 3, 
      "L": 8, "O": 0, "V": 7
    expect(dj.solution_map).to.deep.equal(map)
      

