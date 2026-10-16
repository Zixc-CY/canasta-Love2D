require('Code.Pelota')
local HUD = require('Code.HUD')
--require('Code.jugador')
require ('Code.sonido')
signal = require ('Code.signal')
require ('Code.Nuevascolisiones')

--=================== DECLARACION ===================

fondo= nil
local maxPuntaje = 10
local tiempoInicial = 10
local hud
juegoCongelado = false

--=================== Cargando ===================

function love.load()
   -- iniciarjugador()
    cargarsonidos()
    hud = HUD.new(maxPuntaje, tiempoInicial)
    nuevascolisiones(hud)

    signal.register("agregar_tiempo", function(segundos)
        hud:agregartiempo(segundos)
    end)

    signal.register("puntaje_maximo", function(puntaje)
        juegoCongelado = true
    end)

    signal.register ("sumar_punto", function()
        signal.emit("agregar_tiempo", 5)
        hud:sumarPunto()
    end)    

    signal.register("reiniciar", function()
        hud:reiniciar()
        pelota:reiniciar()
        juegoCongelado = false
    end)

    love.window.setTitle("Cronómetro y Puntaje")
    fondo= love.graphics.newImage("Backround/Fondo.jpeg")
end            

--=================== Actualización ===================

function love.update(dt)
    --pelota:update()
    if not juegoCongelado then
        pelota:actualizar(dt)
    --actualizarjugador (dt) 
        cargarnuevascolisiones(dt)
    end
    hud:actualizar(dt)
end

function love.keypressed(key)
    if key == "r" then
        signal.emit("reiniciar")
        return
    end

    if key == "space" or key == "left" or key == "a" or key == "right" or key == "d" then
        hud:iniciar()
    end
end

--=================== Dibujo ===================

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
