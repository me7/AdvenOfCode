# scope: read text by line > convert to int > calucate > sum
# lib: math.sum 
# lib: os.getAppDir().setCurrentDir
# lib: sequtils --> map, strip, parseInt

# tip: tail recursion --> last line call itself (no + - * /)
# tip: tail recursion fail when stack full --> get = ulimit -s --> set = ulimit -s 18000
# tip: strip last line
# tip: string.strip.split('\n')


import strutils, strformat, sequtils
import math, os, sugar

os.getAppDir().setCurrentDir

proc fuelNeeded(mass: int): int = 
  let need = (mass div 3) - 2
  return if need > 0: need else: 0
assert [12, 14, 1969, 100756].map(fuelNeeded) == [2, 2, 654, 33583]

proc fuelNeededIncludeFuelMass(moduleMass: int, fuelUse:int = 0):int =
  var fuelMass = moduleMass.fuelNeeded
  return if fuelMass == 0: 
    fuelUse 
  else: 
    fuelNeededIncludeFuelMass(fuelMass, fuelMass + fuelUse)
assert [12, 14, 1969, 100756].mapIt(fuelNeededIncludeFuelMass(it,0)) == [2, 2, 966, 50346]

var input1 = readFile("d01.in").strip.split('\n').map(parseInt)
echo input1.map(fuelNeeded).sum
echo input1.mapIt(fuelNeededIncludeFuelMass(it, 0)).sum
