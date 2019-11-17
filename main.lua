--[[     VARIABLES    --]]
local Gamestate = require "hump.gamestate"
local ButtonManager = require "ButtonManager"
local sti = require "sti"

--Game States
local menu = {}
local BoTState = {} --Tsushima
local BoMState = {} --Midway
local BoJState = {} --Jutland

--Ships
local ships = {
    {name = "Aircraft Carrier", health = 6, cost = 100, damage = 0, imgsrc = love.graphics.newImage("Art/AircraftCarrierPixel.png")},
    {name = "Battleship", health = 5, cost = 50, damage = 2, imgsrc = love.graphics.newImage("Art/BattleshipPixel.png")},
    {name = "Minelayer", health = 4, cost = 40, damage = 1, imgsrc = love.graphics.newImage("Art/MinelayerPixel.png")},
    {name = "Submarine", health = 4, cost = 40, damage = 5, imgsrc = love.graphics.newImage("Art/SubmarinePixel.png")},
    {name = "Destroyer", health = 4, cost = 40, damage = 3, imgsrc = love.graphics.newImage("Art/DestroyerPixel.png")}
}
--Music
local MenuMusic = love.audio.newSource("Music/Menu.mp3","stream")
local GameplayMusic = love.audio.newSource("Music/Game.mp3","stream")

--Sound FX
local StartFX = love.audio.newSource("SoundFX/Start.wav","static")
local InvalidFX = love.audio.newSource("SoundFX/Invalid.mp3","static")
local ShootFX = love.audio.newSource("SoundFX/Shoot.mp3","static")
local PlaceMineFX = love.audio.newSource("SoundFX/PlaceMine.wav","static")
local LoseFX = love.audio.newSource("SoundFX/Lose.wav","static")
local ExplosionFX = love.audio.newSource("SoundFX/Explosion.wav","static")
local CoinFX = love.audio.newSource("SoundFX/Coin.wav","static")

--[[      MENU     --]]

function love.load()
    love.window.setFullscreen(true, "desktop")
    love.audio.play(StartFX)
    love.graphics.setFont(love.graphics.newFont("Fonts/silver.ttf", 100))
    screen = { w = love.graphics.getWidth(), h = love.graphics.getHeight() }
    NRTextLogo = love.graphics.newImage("Art/TextLogo.png")
    ACSIText = love.graphics.newImage("Art/ACSIText.png")
    background = love.graphics.newImage("Art/OceanBackground.png")
    --Switch to Menu state
    Gamestate.registerEvents()
    Gamestate.switch(menu)
end

function menu.enter()
    love.mouse.setVisible(false)
    --Music
    MenuMusic:setLooping(true)
    love.audio.play(MenuMusic)
    love.audio.stop(GameplayMusic)
    love.mouse.setVisible(true)
end

function love.mousepressed( x, y, msbutton, istouch, presses )
    ButtonManager.mousepressed(x,y,msbutton)
 end
 
 function love.mousereleased( x, y, msbutton, istouch, presses )
    ButtonManager.mousereleased(x,y,msbutton)
 end

 function menu:keypressed(key, scancode, isrepeat)
    if key == "escape" then
        love.event.quit()
    end
 end

function menu:draw()
    for i = 0, love.graphics.getWidth() / background:getWidth() do
        for j = 0, love.graphics.getHeight() / background:getHeight() do
            love.graphics.draw(background, i * background:getWidth(), j * background:getHeight())
        end
    end

    love.graphics.push()
    love.graphics.scale(0.5, 0.5)
    love.graphics.draw(NRTextLogo, 80, 150)
    love.graphics.draw(ACSIText, 80, 450)
    love.graphics.pop()

    --Buttons
    BoTButton = ButtonManager.new("Battle of Tsushima",80,450,200,100)
    BoTButton.onClick = function()
        Gamestate.registerEvents()
        Gamestate.switch(BoTState)
    end
    BoMButton = ButtonManager.new("Battle of Midway",80,550,200,100)
    BoMButton.onClick = function()
        Gamestate.switch(BoMState)
    end
    BoJButton = ButtonManager.new("Battle of Jutland",80,650,200,100)
    BoJButton.onClick = function()
        Gamestate.switch(BoLGState)
    end

    love.graphics.setColor(0,0,0)
    ButtonManager.draw()
    love.graphics.setColor(255,255,255)
 end



--[[      BoT     --]]
function BoTState.enter()
    love.audio.stop(MenuMusic)
    GameplayMusic:setLooping(true)
    love.audio.play(GameplayMusic)
    local CurrentPoints = 250
    BoTmap = sti("Maps/BoT.lua") --load map
    --Create Sprite Layer
    BoTmap:addCustomLayer("Sprite Layer", 3)
end

function BoTState:draw()
    love.graphics.setColor(1, 1, 1)
    BoTmap:draw()
end

function BoTState:update(dt)
    BoTmap:update(dt)
 end

function BoTState:keypressed(key, scancode, isrepeat)
    if key == "escape" then
        Gamestate.switch(menu)
    end
end


--[[      BoM     --]]
function BoMState.enter()
    love.audio.stop(MenuMusic)
    GameplayMusic:setLooping(true)
    love.audio.play(GameplayMusic)
    local CurrentPoints = 250
    BoMmap = sti("Maps/BoT.lua") --load map
    --Create Sprite Layer
    BoMmap:addCustomLayer("Sprite Layer", 3)
end

function BoMState:draw()
    love.graphics.setColor(1, 1, 1)
    BoMmap:draw()
end

function BoMState:update(dt)
    BoMmap:update(dt)
 end

function BoMState:keypressed(key, scancode, isrepeat)
    if key == "escape" then
        Gamestate.switch(menu)
    end
end

--[[      BoJ     --]]
function BoJState.enter()
    love.audio.stop(MenuMusic)
    GameplayMusic:setLooping(true)
    love.audio.play(GameplayMusic)
    local CurrentPoints = 250
    BoJmap = sti("Maps/BoT.lua") --load map
    --Create Sprite Layer
    BoJmap:addCustomLayer("Sprite Layer", 3)
end

function BoJState:draw()
    love.graphics.setColor(1, 1, 1)
    BoJmap:draw()
end

function BoJState:update(dt)
    BoJmap:update(dt)
 end

function BoJState:keypressed(key, scancode, isrepeat)
    if key == "escape" then
        Gamestate.switch(menu)
    end
end


