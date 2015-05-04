function path_show(x,y, room)
% Give the path data from the painter_play function and the room used
% and this function shows how the painter walked

room = room+2;
colormap([1, 1 1; 0.5 0.5 0.5; 0 0 0])
image(room);
pause(1)

for t=1:length(x)
   
    room(x(t), y(t)) = 3;
    
    if t~=1
       room(x(t-1), y(t-1)) = 1;
    end
    
    image(room)
    drawnow
end

end

