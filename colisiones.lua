choca1= false
choca2= false
choca3= false 
chocay1= false
chocay2= false
chocay3= false
collisionador1={
    x= 0,
    y= 550,
    ancho= 800,
    alto= 50,
    hitbox= 0,
    hitboxy= 0
}
collisionador2={
    x= 650,
    y= 250,
    ancho= 70,
    alto= 10,
    hitbox= 0,
    hitboxy= 0
}
collisionador3={
    x= 720,
    y= 170,
    ancho= 10,
    alto= 100,
    hitbox= 0,
    hitboxy= 0
}
hubocolision= false
colisionencurso= false

function comprobarcolision(x1, y1, ancho1, alto1, x2, y2, ancho2, alto2)
    return x1 < x2 + ancho2 and
        x1 + ancho1 > x2 and
           y1 < y2 + alto2 and      
        y1 + alto1 > y2
end
function cargarcolisionadores(dt)
    jugador.hitbox= jugador.x - jugador.ancho/2
    jugador.hitboxy= jugador.y - jugador.alto/20
    jugador.escalahitbox1= jugador.ancho/1.1
    jugador.escalahitbox2= jugador.alto /1.4
    collisionador1.hitbox= collisionador1.x
    collisionador1.hitboxy= collisionador1.y  
    collisionador2.hitbox= collisionador2.x
    collisionador2.hitboxy= collisionador2.y       
    collisionador3.hitbox= collisionador3.x
    collisionador3.hitboxy= collisionador3.y   

    jugador.choca1= comprobarcolision(
        jugador.hitbox,
        jugador.hitboxy,
        jugador.escalahitbox1,
        jugador.escalahitbox2,
        collisionador1.hitbox,
        collisionador1.hitboxy,
        collisionador1.ancho,
        collisionador1.alto
    )
    jugador.choca2= comprobarcolision(
        jugador.hitbox,
        jugador.hitboxy,
        jugador.escalahitbox1,
        jugador.escalahitbox2,
        collisionador2.hitbox,
        collisionador2.hitboxy,
        collisionador2.ancho,
        collisionador2.alto
    )
    jugador.choca3= comprobarcolision(
        jugador.hitbox,
        jugador.hitboxy,
        jugador.escalahitbox1,
        jugador.escalahitbox2,
        collisionador3.hitbox,
        collisionador3.hitboxy,
        collisionador3.ancho,
        collisionador3.alto
    )
    
    if jugador.choca3 then
        jugador.x= jugador.anteriorx
        jugador.hitbox= jugador.x - (jugador.origenx * 0.043)
    end
    if jugador.choca1 then
        jugador.x= jugador.anteriorx
        jugador.hitbox= jugador.x - (jugador.origenx * 0.043)
    end
    
    jugador.hitboxy= jugador.y - (jugador.origeny * 0.060)
    
    jugador.chocay1= comprobarcolision(
        jugador.hitbox,
        jugador.hitboxy,
        jugador.escalahitbox1,
        jugador.escalahitbox2,
        collisionador1.hitbox,
        collisionador1.hitboxy,
        collisionador1.ancho,
        collisionador1.alto
    )
    jugador.chocay2= comprobarcolision(
        jugador.hitbox,
        jugador.hitboxy,    
        jugador.escalahitbox1,
        jugador.escalahitbox2,
        collisionador2.hitbox,
        collisionador2.hitboxy,
        collisionador2.ancho,
        collisionador2.alto
    )
    jugador.chocay3= comprobarcolision(
        jugador.hitbox,
        jugador.hitboxy,
        jugador.escalahitbox1,
        jugador.escalahitbox2,
        collisionador3.hitbox,
        collisionador3.hitboxy,
        collisionador3.ancho,
        collisionador3.alto
    )
    
    if jugador.chocay1 then
        jugador.velocidady= 0
        jugador.hitboxy= collisionador1.y - jugador.escalahitbox2 - 0.6
        jugador.y= jugador.hitboxy + (jugador.origeny * 0.060)
        hubocolision= true
    elseif jugador.chocay3 then
        jugador.y= jugador.anteriory + 2
        jugador.hitboxy= jugador.y - (jugador.origeny * 0.060)
        hubocolision= true
    end
    
    if jugador.choca2 then
        if not colisionencurso then
            puntaje= puntaje + 1
            colisionencurso= true
            sfx:play()

        end
    else
        colisionencurso= false 
    end
end