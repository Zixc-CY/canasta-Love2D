musica= nil
sfx= nil
function cargarsonidos()
     musica= love.audio.newSource("musica.mp3", "stream")
    musica:setLooping(true)
    musica:play()
    sfx= love.audio.newSource("sfx.mp3", "static")
    sfx:setVolume(1)
end