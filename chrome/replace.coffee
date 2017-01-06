Replace = require '../common/replace-all'

chrome.runtime.sendMessage 'get-do-replacement', (doReplacement) ->
  console.log "doReplacement: #{doReplacement}"
  if doReplacement then Replace.watchNodesAndReplaceText('p')
  null
