act = chrome.browserAction
doReplacement = yes

act.onClicked.addListener (tab) ->
  iconPath = if doReplacement then 'res/trump_headshot19off.png'
  else 'res/trump_headshot19.png'

  act.setIcon { path: iconPath }
  doReplacement = not doReplacement
  console.log "set trump vision to #{doReplacement}"

chrome.runtime.onMessage.addListener (req, sender, sendResponse) ->
  switch req
    when 'get-do-replacement' then sendResponse doReplacement
