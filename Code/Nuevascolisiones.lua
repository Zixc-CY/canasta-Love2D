Suelo = {
    x = 0,
    Y = 550,
    ancho = 1600,
    alto = 20
}
PelotaConfig = {
    x = 150,
    y = 330,
}
Tablero = {
    x = 720,
    y = 210,
    alto = 100,
    ancho = 10
}
Aro = {
    x = 680,
    y = 260,
    alto = 10,
    ancho = 70
}

function beginContact(a, b, coll)
    if (a == pelota.fixture and b == aroacople) or
     (a == aroacople and b == pelota.fixture) then
        local vx, vy = pelota:getLinearVelocity()
        if vy > 0 then
            puntaje = puntaje + 1
            sfx:play()
        end
    end
    if (a == pelota.fixture and b == sueloacople) or
     (a == sueloacople and b == pelota.fixture) then
        pelota:setEnElSuelo(true)
    end
end
function endContact(a,b,coll)
    if (a == pelota.fixture and b == sueloacople) or
     (a == sueloacople and b == pelota.fixture) then
        pelota:setEnElSuelo(false)
    end
    
end
function nuevascolisiones()
    love.physics.setMeter(64)
    world = love.physics.newWorld(0, 9.81 * 64, true)

    world:setCallbacks(beginContact, endContact)

    suelo = love.physics.newBody(world, Suelo.x, Suelo.Y)
    sueloforma = love.physics.newRectangleShape(Suelo.ancho, Suelo.alto)
    sueloacople = love.physics.newFixture(suelo, sueloforma)
    sueloacople:setFriction(5)

    pelota = Pelota.new(world, PelotaConfig.x, PelotaConfig.y)

    tablero = love.physics.newBody(world, Tablero.x, Tablero.y)
    tableroforma = love.physics.newRectangleShape(Tablero.ancho, Tablero.alto)  
    tableroacople = love.physics.newFixture(tablero, tableroforma)
    tableroacople: setFriction(0)
    tableroacople:setRestitution(0.9)

    aro = love.physics.newBody(world, Aro.x, Aro.y)
    aroforma = love.physics.newRectangleShape(Aro.ancho, Aro.alto)
    aroacople = love.physics.newFixture(aro, aroforma)
    aroacople:setSensor(true)
end
function cargarnuevascolisiones(dt)
    world:update(dt)
    
end
function dibujarcolisiones()
    love.graphics.polygon("line", suelo:getWorldPoints(sueloforma:getPoints()))
    love.graphics.circle("line", pelota:getX(), pelota:getY(), pelota.forma:getRadius())
    love.graphics.polygon("line", tablero:getWorldPoints(tableroforma:getPoints()))
    love.graphics.polygon("line", aro:getWorldPoints(aroforma:getPoints()))
end