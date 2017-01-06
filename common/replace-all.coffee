insertText = " Sad!"

addSad = (txt) ->
  finalText = txt[-(insertText.length)..]
  if (finalText isnt insertText)
  then txt.replace /((?:\.|\?|!)?)\s*$/, (all, g1) ->
    (if g1 is '' then '.' else g1) + insertText
  else txt

htmlColl2Arr = (coll) -> Array.prototype.slice.call coll, 0

watchNodesAndReplaceText = (tag) ->
  changeText = (node) -> node.innerHTML = addSad(node.innerHTML)
  rplc = (node) ->
    htmlColl2Arr(node.querySelectorAll?(tag) ? []).forEach changeText
  rplc(document)
  [500,1000,2000].forEach (timeout) -> setTimeout (-> rplc(document)), timeout
  obsv = new MutationObserver (records) -> records.forEach (rec) ->
    node = rec.target
    if rec.type is 'childList'
    then htmlColl2Arr(rec.addedNodes).forEach rplc
    null
  setTimeout (-> obsv.observe document,
      childList: on
      subtree: on),
    2000
  null

module.exports =
  watchNodesAndReplaceText: watchNodesAndReplaceText
