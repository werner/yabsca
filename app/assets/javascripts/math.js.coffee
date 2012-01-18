Math.fib = (n) ->
    s = 0
    return s if n == 0
    if n == 1
      s += 1
    else
      Math.fib(n - 1) + Math.fib(n - 2)
