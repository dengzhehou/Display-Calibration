% Clear the workspace and the screen
sca;
close all;
clear;

Screen('Preference', 'SkipSyncTests', 1);

% Here we call some default settings for setting up Psychtoolbox
PsychDefaultSetup(1);

% Get the screen numbers. This gives us a number for each of the screens
% attached to our computer.
screens = Screen('Screens');

% To draw we select the maximum of these numbers. So in a situation where we
% have two screens attached to our monitor we will draw to the external
% screen.
screenNumber = max(screens);

% Define black and white (white will be 1 and black 0). This is because
% in general luminace values are defined between 0 and 1 with 255 steps in
% between. With our setup, values defined between 0 and 1.
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);

% Do a simply calculation to calculate the luminance value for grey. This
% will be half the luminace value for white
color_index = black:3:white;

% The avaliable keys to press
escapeKey = KbName('ESCAPE');
hitKey = KbName('5');

HideCursor(screenNumber);

% Open an on screen window using PsychImaging and color it grey.
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, black);

% Get the size of the on screen window
% [screenXpixels, screenYpixels] = Screen('WindowSize', window);

% Get the centre coordinate of the window in pixels
% For help see: help RectCenter
[xCenter, yCenter] = RectCenter(windowRect);

% Make a base Rect of 200 by 200 pixels. This is the rect which defines the
% size of our square in pixels. Rects are rectangles, so the
% sides do not have to be the same length. The coordinates define the top
% left and bottom right coordinates of our rect [top-left-x top-left-y
% bottom-right-x bottom-right-y]. The easiest thing to do is set the first
% two coordinates to 0, then the last two numbers define the length of the
% rect in X and Y. The next line of code then centers the rect on a
% particular location of the screen.
baseRect = [0 0 800 800];

% Center the rectangle on the centre of the screen using fractional pixel
% values.
% For help see: CenterRectOnPointd
centeredRect = CenterRectOnPointd(baseRect, xCenter, yCenter);

Screen('TextSize', window, 48);

for i = 1:length(color_index)
    % Convert our current number to display into a string
    numberString = num2str(color_index(i));
    
    if i <= 128
        text_color = white;
    elseif i > 128
        text_color = black;
    end
        
    % Draw our number to the screen
    DrawFormattedText(window, numberString, 'center', 'center', text_color);
    % Flip to the screen
    Screen('Flip', window);
    
    % Wait for at least ‘waitPeriodSecs’ seconds. Try to be precise.
    WaitSecs(1);
    
    % Draw the square to the screen. For information on the command used in
    % this line see Screen FillRect?
    Screen('FillRect', window, color_index(i), centeredRect);
    % Flip to the screen
    Screen('Flip', window);
    
    checkKeyPress

end

% Now we have drawn to the screen we wait for a keyboard button press (any
% key) to terminate the demo.
KbStrokeWait;

ShowCursor();

% Clear the screen.
sca;