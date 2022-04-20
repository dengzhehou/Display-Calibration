% This is the cue which determines whether we exit the demo
exitDemo = false;

% Loop the animation until the key is pressed
while exitDemo == false

    % Check the keyboard to see if a button has been pressed
    [keyIsDown,secs, keyCode] = KbCheck;

    % Depending on the button press
    if keyCode(hitKey)
        exitDemo = true;
    elseif keyCode(escapeKey)
        Screen('CloseAll');
        return
    end
end
pause(0.3);