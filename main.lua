require('Code.Pelota')
local HUD = require('Code.HUD')
--require('Code.jugador')
require ('Code.sonido')
require ('Code.class')
require ('Code.signal')
require ('Code.timer')
require ('Code.Nuevascolisiones')
--=================== DECLARACION ===================
fondo= nil
local maxPuntaje = 10
local tiempoInicial = 120
local hud
--cargando
function love.load()
   -- iniciarjugador()
    cargarsonidos()
    hud = HUD.new(maxPuntaje, tiempoInicial)
    nuevascolisiones(hud)
    love.window.setTitle("Cronómetro y Puntaje")
    fondo= love.graphics.newImage("Backround/Fondo.jpeg")
end            

function love.update(dt)
    --pelota:update()
    pelota:actualizar(dt)
    --actualizarjugador (dt) 
    cargarnuevascolisiones(dt)
    hud:actualizar(dt)
end

function love.keypressed(key)
    if key == "space" or key == "r" or key == "left" or key == "a" or key == "right" or key == "d" then
        hud:iniciar()
    end
end

function love.draw()
    love.graphics.draw(fondo,0,0,0,0.5,0.625)
    hud:dibujar()
   -- if jugador.choca1 or jugador.choca2 or jugador.choca3 then
      --  love.graphics.print("¡Colisión detectada!", 10, 10)
  --  end
    pelota:dibujar()
    --pelota:draw()
   -- dibujarjugador()
    --dibujarcolisiones()
end
