musica= nil
sfx= nil
function cargarsonidos()
     musica= love.audio.newSource("Music/musica.mp3", "stream")
    musica:setLooping(true)
    musica:play()
    sfx= love.audio.newSource("SFX/sfx.mp3", "static")
    sfx:setVolume(1)
end