# struggle: on part two. How to check long duplicate but not using loop?

import strutils, strformat, sequtils
type dupCounter = ref object
  letter: char # currrent letter
  isDecrease: bool # new letter greater than previous letter
  lcount: int # current count of the letter
  double: int # double occurent of char
  triple: int # triple up occurent

proc newDupCounter(letter:char):dupCounter =
  dupCounter(
    letter: letter,
    isDecrease: false,
    lcount: 1,
    double:0,
    triple: 0
  )

proc add(d: var dupCounter, c:char) =
  if d.isDecrease: return
  if c < d.letter:
    d.isDecrease = true
  elif c == d.letter:
    if d.lcount == 1:
      d.double.inc
    elif d.lcount == 2:
      d.triple.inc
    d.lcount.inc
  else:
    d.letter = c
    d.lcount = 1

proc isPassword(d: dupCounter): bool =
  d.double > d.triple and not d.isDecrease

proc toDupCounter(num:int): dupCounter =
  # generate dupcounter from integer
  let n = num.intToStr
  var dup = newDupCounter(n[0])
  for i in 1..n.len-1:
    dup.add n[i]
  return dup


proc isPassword(num:int): bool =
  let n = num.intToStr
  assert n.len == 6
  
  for i in 1..n.len-1:
    # never decrease
    if n[i] < n[i-1]:
      return false
  
  var adj = 0
  for i in 1..n.len-1:
    # 2 adjacent is the same 11 = 111 = 111111
    if n[i] == n[i-1]:
      adj.inc

  if adj < 1: return false
    
  # 2 digit adjacent not count in large group 
  if adj == 1:
    for i in 2..n.len-1:
      if n[i] == n[i-1] and n[i] == n[i-2]:
        return false

  return true

if defined(test):
  echo [111111, 223450, 123789].map(isPassword) #tff
  echo [112233, 123444, 111122].map(isPassword) #tft
  echo [111111, 223450, 123789].mapIt(toDupCounter(it).isPassword) #tff
  echo [112233, 123444, 111122].mapIt(toDupCounter(it).isPassword) #tft
  echo [112233, 123444, 111122].mapIt(toDupCounter(it).repr) #tft

when isMainModule:
  let input = 128392..643281
  var count = 0
  for n in input:
    if isPassword(n):
      count.inc
  echo count

  # part 2
  count = 0
  for n in input:
    if toDupCounter(n).isPassword:
      count.inc
  echo count