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

function HUD:iniciar()
    if not self.juegoActivo and self.puntaje < self.puntajeMaximo and self.tiempo > 0 then
        self.juegoActivo = true
    end
end

function HUD:sumarPunto()
    self.puntaje = self.puntaje + 1
    if self.puntaje >= self.puntajeMaximo then
        self.juegoActivo = false
    end
end

function HUD:actualizar(dt)
    if not self.juegoActivo then
        return
    end

    self.tiempo = math.max(0, self.tiempo - dt)
    if self.tiempo == 0 then
        self.juegoActivo = false
    end
end

function HUD:dibujar()
    love.graphics.print("Puntaje: " .. self.puntaje, 380, 40, 0, 2, 2)
    love.graphics.print("Tiempo: " .. math.ceil(self.tiempo), 20, 20, 0, 2, 2)

    if self.puntaje >= self.puntajeMaximo then
        love.graphics.print("GANASTE", 20, 80)
    elseif self.tiempo <= 0 then
        love.graphics.print("PERDISTE", 400, 300, 0, 3, 3)
    end
end

return HUD
