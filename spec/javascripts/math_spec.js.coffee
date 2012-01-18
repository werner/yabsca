#= require math

describe 'Math:', ->
  describe 'fib()', ->
    it 'should calculate the numbers correctly up to fib(16)', ->
      fib = [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987]
      expect(Math.fib(i)).toEqual fib[i] for i in [0..16]
