require('Code.Pelota')
local HUD = require('Code.hud')
--require('Code.jugador')
require ('Code.sonido')
signal = require ('Code.signal')
require ('Code.Nuevascolisiones')
--=================== DECLARACION ===================
canasta= nil
fondo= nil
local maxPuntaje = 10
local tiempoInicial = 40
local hud
juegoCongelado = false

--=================== Cargando ===================

function love.load()
    fuente = love.graphics.newFont("Assets/Fonts/ft.ttf", 16)
    fuente:setFilter ("linear", "linear")
love.graphics.setFont(fuente)
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
    
    signal.register("tiempoAgotado", function(puntaje)
        juegoCongelado = true
    end)

    signal.register("reiniciar", function()
        hud:reiniciar()
        pelota:reiniciar()
        juegoCongelado = false
    end)

    love.window.setTitle("Cronómetro y Puntaje")
    fondo= love.graphics.newImage("Backround/Fondo.jpeg")
    canasta= love.graphics.newImage("Backround/Canasta.png")
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
    pelota:dibujar()
     love.graphics.draw(canasta, 578, 20,0, 0.7, 0.9)
    hud:dibujar()
   -- if jugador.choca1 or jugador.choca2 or jugador.choca3 then
      --  love.graphics.print("¡Colisión detectada!", 10, 10)
  --  end
    --pelota:draw()
   -- dibujarjugador()
    --dibujarcolisiones()
end
