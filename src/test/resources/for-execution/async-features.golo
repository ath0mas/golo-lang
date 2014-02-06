module golotest.execution.Asyncfeatures

import gololang.Async

local function except = -> java.lang.RuntimeException("Plop")

function check_map = {
  let ok = setFuture("Ok"): map(|v| -> v + "!"): get()
  let failed = failedFuture(except()): map(|v| -> v): get()
  return [ok, failed]
}

function check_flatMap = {
  let ok = setFuture("Ok"): flatMap(|v| -> setFuture(v + "!")): get()
  let failed = failedFuture(except()): flatMap(|v| -> setFuture(v)): get()
  return [ok, failed]
}

function check_filter = {
  let pred = |s| -> s: startsWith("Ok")
  let ok = setFuture("Ok"): filter(pred): get()
  let bam = setFuture("Foo"): filter(pred): get()
  let failed = failedFuture(except()): filter(pred): get()
  return [ok, bam, failed]
}
