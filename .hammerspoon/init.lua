-- hs.hotkey.bind({"ctrl"}, "space", function()
--     local app = hs.application.get("kitty")
--     if app then
--         if not app:mainWindow() then
--             app:selectMenuItem({"kitty", "New OS window"})
--         elseif app:isFrontmost() then
--             app:hide()
--         else
--             app:activate()
--         end
--     else
--         hs.application.launchOrFocus("kitty")
--     end
-- end)

hs.hotkey.bind({"ctrl", "shift"}, "C", function()
  local app = hs.application.get("kitty")

  if app then
      if not app:mainWindow() then
          app:selectMenuItem({"kitty", "New OS window"})
      elseif app:isFrontmost() then
          app:hide()
      else
          app:activate()
      end
  else
      hs.application.launchOrFocus("kitty")
      app = hs.application.get("kitty")
  end

  app:mainWindow():moveToUnit'[100,50,0,0]'
  app:mainWindow().setShadows(false)
end)
