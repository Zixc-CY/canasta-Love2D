local HUD = {}
HUD.__index = HUD

function HUD.new(puntajeMaximo, duracion)
    local self = setmetatable({}, HUD)

    self.puntajeMaximo = puntajeMaximo
    self.duracion = duracion
    self:reiniciar()

    return self
end

function HUD:reiniciar()
    self.puntaje = 0
    self.tiempo = self.duracion
    self.juegoActivo = false
end

function HUD:agregartiempo(segundos)
    if not self.juegoActivo then
        return
    end

    self.tiempo = self.tiempo + segundos
end

function HUD:iniciar()
    if not self.juegoActivo and self.puntaje < self.puntajeMaximo and self.tiempo > 0 then
        self.juegoActivo = true
    end
end

function HUD:sumarPunto()
    if self.puntaje >= self.puntajeMaximo then
        return
    end

    self.puntaje = self.puntaje + 1

    if self.puntaje >= self.puntajeMaximo then
        self.juegoActivo = false
        signal.emit("puntaje_maximo", self.puntaje)
    end
end

function HUD:actualizar(dt)
    if not self.juegoActivo then
        return
    end

    self.tiempo = math.max(0, self.tiempo - dt)
    if self.tiempo == 0 then
        self.juegoActivo = false
        signal.emit("tiempoAgotado")
    end
end

function HUD:dibujar()
    love.graphics.push("all")

    love.graphics.setColor(0, 0.7, 0)
    love.graphics.print("Puntaje: " .. self.puntaje, 650, 20, 0, 2, 2)

    love.graphics.setColor(1, 1, 0)
    love.graphics.print("Tiempo: " .. math.ceil(self.tiempo), 20, 20, 0, 2, 2)

    if self.puntaje >= self.puntajeMaximo then
        love.graphics.setColor(0, 0, 1)
        love.graphics.print(
            "GANASTE",
            (love.graphics.getWidth() - love.graphics.getFont():getWidth("GANASTE") * 3) / 2,
            (love.graphics.getHeight() - love.graphics.getFont():getHeight() * 3) / 2,
            0,
            5,
            5
        )
    elseif self.tiempo <= 0 then
        love.graphics.setColor(1, 0, 0)
        love.graphics.print(
            "PERDISTE",
            (love.graphics.getWidth() - love.graphics.getFont():getWidth("PERDISTE") * 3) / 2,
            (love.graphics.getHeight() - love.graphics.getFont():getHeight() * 3) / 2,
            0,
            5,
            5
        )
    end

    love.graphics.pop()
end

return HUD
