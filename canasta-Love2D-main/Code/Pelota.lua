--=================== CLASE PELOTA ===================
Pelota = {}
Pelota.__index = Pelota

function Pelota.new(world, x, y)
    local self = setmetatable({}, Pelota)

    self.posicionInicialX = x
    self.posicionInicialY = y

    self.ancho = 175 * 0.40
    self.alto = 184 * 0.40
    self.radio = self.ancho * 0.4
    self.velocidad = 300

    self.salto = {
        inicial = 0,
        fuerza = 300,
        limite = 400,
    }
    self.enElSuelo = false

    self.body = love.physics.newBody(world, x, y, "dynamic")
    self.forma = love.physics.newCircleShape(self.radio)
    self.fixture = love.physics.newFixture(self.body, self.forma, 1)
    self.fixture:setRestitution(0.7)
    self.fixture:setFriction(5)
    self.body:setAngularDamping(2.5)

    self.imagen = love.graphics.newImage("Assets/Pelota.png")
    
    self.imgOrigenX = 742.5
    self.imgOrigenY = 460
    self.imgDiametro = 524.5
    self.escala = (self.radio * 2) / self.imgDiametro
   
    self.index_vfx_move= 1
    self.anim_vfx_move_vel= 10
    self.vfx_move={"VFX/vsx.png"}
    

    return self
end

function Pelota:getX()
    return self.body:getX()
end

function Pelota:getY()
    return self.body:getY()
end

function Pelota:getLinearVelocity()
    return self.body:getLinearVelocity()
end

function Pelota:setLinearVelocity(vx, vy)
    self.body:setLinearVelocity(vx, vy)
end
function Pelota:update (dt)
    self.anteriorx = self:getX()
    self.anteriory = self:getY()

 if love.keyboard.isDown ("space") then
        if #self.index_vfx_move  > 0 then
            self.index_vfx_move = self.index_vfx_move + (self.anim_vfx_move_vel * dt)
            if self.index_vfx_move > #self.vfx_move then
                self.index_vfx_move = 1
            end
        end
    else
        self.index_vfx_move = 1
        
    end
end
function Pelota:draw()
    local x = self:getX()
    local y = self:getX()
if pelota.salto.inicial >= pelota.salto.limite then
        local frame = math.floor(jugador.index_vfx_move)
        if jugador.vsx_move[frame] then
            love.graphics.draw(jugador.vfx, jugador.vsx_move[frame], pelota:getX(), pelota:getY(), 0, 1.1, 1.1, jugador.origenx / 1.9, jugador.origeny/0.8)
        end
    end
    
end
function Pelota:applyLinearImpulse(ix, iy)
    self.body:applyLinearImpulse(ix, iy)
end

function Pelota:setPosition(x, y)
    self.body:setPosition(x, y)
end

function Pelota:setEnElSuelo(valor)
    self.enElSuelo = valor
end

function Pelota:estaEnElSuelo()
    return self.enElSuelo
end

function Pelota:reiniciar()
    self:setPosition(self.posicionInicialX, self.posicionInicialY)
    self.body:setLinearVelocity(0, 0)
    self.salto.inicial = 0
end

function Pelota:actualizar(dt)

    if self.enElSuelo then
        if love.mouse.isDown(1) or love.keyboard.isDown("space") then
            if self.salto.inicial < self.salto.limite then
                self.salto.inicial = self.salto.inicial + (self.salto.fuerza * dt)
            else
                self.salto.inicial = self.salto.limite
            end
        else
            if self.salto.inicial > 0 then
                self:applyLinearImpulse(0, -self.salto.inicial)
                self.salto.inicial = 0
            end
        end
    end

    if love.keyboard.isDown("r") then
        self:reiniciar()
        puntaje = 0
        tiempo = 120
    end

    local vx, vy = self:getLinearVelocity()
    if love.keyboard.isDown("left", "a") then
        self:setLinearVelocity(-self.velocidad, vy)
    elseif love.keyboard.isDown("right", "d") then
        self:setLinearVelocity(self.velocidad, vy)
    end
end

function Pelota:dibujar()
    love.graphics.draw(
        self.imagen,
        self:getX(), self:getY(),
        self.body:getAngle(),
        self.escala, self.escala,
        self.imgOrigenX, self.imgOrigenY
    )
end
