jugador={
    x= 150,
    y= 530,
    ancho,
    alto,
    origenx,
    origeny,
    hitbox= 0,
    hitboxy= 0,
    escalahitbox1= 0,
    escalahitbox2= 0,
    velocidad= 300,
    anteriorx= 0,
    anteriory= 0,
    velocidady= 0,
    gravedad= 900,
    sheet= nil,
    anim_move={},
    index_anim_move= 1,
    anim_move_vel=10,
    vsx= nil,
    vsx_move={},
    index_vsx_move= 1,
    anim_vsx_move_vel= 10,

}
salto= {
    inicial= 0,
    fuerza= 700,
    limite= 900,
}

 function iniciarjugador()
   jugador.sheet= love.graphics.newImage("Assets/sheet.png")
    for i = 0, 7, 1 do
        table.insert(jugador.anim_move, love.graphics.newQuad(175 * i, 0, 175, 184, 1401, 184)) 
    end
    jugador.vsx= love.graphics.newImage("VFX/vsx.png")
    for i = 1, 4, 1 do
        table.insert(jugador.vsx_move, love.graphics.newQuad(118 * i, 0, 100, 116, 474, 116))
    end
    jugador.ancho= 175 * 0.40
    jugador.alto= 184 * 0.40
    jugador.origenx= 175 / 1.9
    jugador.origeny= 184 / 20 
end

function actualizarjugador(dt)
    jugador.anteriorx= jugador.x
    jugador.anteriory= jugador.y 
    if love.mouse.isDown(1) or love.keyboard.isDown("space") then
        if salto.inicial < salto.limite then
            salto.inicial= salto.inicial + (salto.fuerza * dt)
        else
            salto.inicial= salto.limite
        end
    else
        if salto.inicial > 0 then
            jugador.velocidady= -salto.inicial
            salto.inicial= 0
        end
    end
    
    if love.keyboard.isDown("r") then
        jugador.x= 150
        jugador.y= 500
        jugador.velocidady= 0
        puntaje= 0
        tiempo= 30 
    end
    
    if love.keyboard.isDown("left", "a") then
        jugador.x= jugador.x - (jugador.velocidad * dt)
    end  
    if love.keyboard.isDown("right", "d") then
        jugador.x= jugador.x + (jugador.velocidad * dt)
    end
    
    jugador.velocidady= jugador.velocidady + (jugador.gravedad * dt)
    jugador.y= jugador.y + (jugador.velocidady * dt)
    if love.keyboard.isDown("left", "a", "right", "d") or not jugador.chocay1 then
        jugador.index_anim_move= jugador.index_anim_move + (jugador.anim_move_vel * dt)
        if jugador.index_anim_move > #jugador.anim_move then
            jugador.index_anim_move= 1
        end
    else
        jugador.index_anim_move = 1
    end
    if love.keyboard.isDown ("space") then
        jugador.index_vsx_move= jugador.index_vsx_move + (jugador.anim_vsx_move_vel * dt)
        if jugador.index_vsx_move > #jugador.vsx_move then
            jugador.index_vsx_move= 1
        end
    else
        jugador.index_vsx_move = 1
        
    end
end
function dibujarjugador()
     if salto.inicial >= salto.limite then
        local frame = math.floor(jugador.index_vsx_move)
        if jugador.vsx_move[frame] then
            love.graphics.draw(jugador.vsx, jugador.vsx_move[frame], jugador.x, jugador.y, 0, 1.1, 1.1, jugador.origenx / 2, jugador.origeny / 0.15)
        end
    end
    local frame = math.floor(jugador.index_anim_move)
    if jugador.anim_move[frame] then
        love.graphics.draw(jugador.sheet, jugador.anim_move[frame], jugador.x, jugador.y, 0, 0.40, 0.40, jugador.origenx, jugador.origeny)
    end

end

