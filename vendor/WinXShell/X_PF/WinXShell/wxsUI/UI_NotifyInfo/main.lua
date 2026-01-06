local TIMER_ID_QUIT = 1001
wait = 2

function onload()
  sui:find("$icon").bkimage = App:GetOption('-i') .. '.png'
  sui:find("$title").text =App:GetOption('-t')
  sui:find("$info").text = App:GetOption('-m')
  pos = App:GetOption('-p')
  if pos ~= nil then
       pos = pos + 0
       local w, h = sui:info('wh')
       sui:move(0, -((h + 10)*pos))
  end
  suilib.call('SetTimer', TIMER_ID_QUIT, wait * 1000)
end

function ontimer(id)
   if id == TIMER_ID_QUIT then sui:close() end
end
