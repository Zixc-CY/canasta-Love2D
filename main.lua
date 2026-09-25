require('Code.jugador')
--require ('Code.colisiones')
require ('Code.sonido')
require ('Code.Nuevascolisiones')
--=================== DECLARACION ===================
fondo= nil
puntaje = 0
maxPuntaje = 10
tiempo = 30  
juegoActivo = false 
--cargando
function love.load()
    iniciarjugador()
    cargarsonidos()
    nuevascolisiones()
    love.window.setTitle("Cronómetro y Puntaje")
    fondo= love.graphics.newImage("Backround/Fondo.jpeg")
end            

function love.update(dt)
    actualizarjugador (dt)
    --cargarcolisionadores(dt)  
    cargarnuevascolisiones(dt)
    if juegoActivo == true then
        tiempo = tiempo - dt

        if tiempo <= 0 then
            tiempo = 0
            juegoActivo = false
        end
    end
end

function love.keypressed(key)
    if key == "space" or key == "r" or key == "left" or key == "a" or key == "right" or key == "d" then
        if juegoActivo == false and puntaje < maxPuntaje and tiempo > 0 then
            juegoActivo = true
        end
        if puntaje >= maxPuntaje then
            juegoActivo = false
        end
    end
end

function love.draw()
    love.graphics.draw(fondo,0,0,0,0.5,0.625)
    love.graphics.print("Puntaje: " .. puntaje, 380, 40, 0, 2, 2)
    love.graphics.print("Tiempo: " .. math.ceil(tiempo), 20, 20, 0, 2, 2)
    if puntaje >= maxPuntaje then
        love.graphics.print("GANASTE", 20, 80)
    end
    if tiempo <= 0 and puntaje < maxPuntaje then
        love.graphics.print("PERDISTE", 400, 300, 0, 3, 3 )
    end                    
    if jugador.choca1 or jugador.choca2 or jugador.choca3 then
        love.graphics.print("¡Colisión detectada!", 10, 10)
    end
    dibujarjugador()
    dibujarcolisiones()
end
