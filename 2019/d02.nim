import strformat, strutils

template say(body: untyped) =
  if not defined(release): echo strformat.`&`(body)

var input = @[1, 0, 0, 3, 1, 1, 2, 3, 1, 3, 4, 3, 1, 5, 0, 3, 2, 6, 1, 19, 1,
    19, 9, 23, 1, 23, 9, 27, 1, 10, 27, 31, 1, 13, 31, 35, 1, 35, 10, 39, 2, 39,
    9, 43, 1, 43, 13, 47, 1, 5, 47, 51, 1, 6, 51, 55, 1, 13, 55, 59, 1, 59, 6,
    63, 1, 63, 10, 67, 2, 67, 6, 71, 1, 71, 5, 75, 2, 75, 10, 79, 1, 79, 6, 83,
    1, 83, 5, 87, 1, 87, 6, 91, 1, 91, 13, 95, 1, 95, 6, 99, 2, 99, 10, 103, 1,
    103, 6, 107, 2, 6, 107, 111, 1, 13, 111, 115, 2, 115, 10, 119, 1, 119, 5,
    123, 2, 10, 123, 127, 2, 127, 9, 131, 1, 5, 131, 135, 2, 10, 135, 139, 2,
    139, 9, 143, 1, 143, 2, 147, 1, 5, 147, 0, 99, 2, 0, 14, 0]

proc parseInput(input: seq[int]): int =
  var c = input
  var pc = 0 #program counter
  while true:
    # say "counter: {pc} value: {c[pc]}"
    case c[pc]
      of 99:
        break
      of 1: #add
        let (a, b, r) = (c[pc+1], c[pc+2], c[pc+3])
        c[r] = c[a] + c[b]
        # say "save {c[a]} + {c[b]} to c[{r}]"
      of 2: # multiply
        let (a, b, r) = (c[pc+1], c[pc+2], c[pc+3])
        c[r] = c[a] * c[b]
        # say "save {c[a]} * {c[b]} to c[{r}]"
      else:
        raise newException(Exception, "invalid opcode")
    pc += 4
  return c[0]


when isMainModule:
  input[1] = 12
  input[2] = 2
  echo input.parseInput

  # part 2
  for noun in 0..99:
    for verb in 0..99:
      input[1] = noun
      input[2] = verb
      let expect = 19690720
      # let expect = 3544289
      if input.parseInput == expect:
        # say "noun: {noun} verb: {verb} got: {expect} answer: {100 * noun + verb}"
        echo 100 * noun + verb
