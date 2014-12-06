function MyGraphPrefs(opt)
% MyGraphPrefs
%
% Modify MATLAB graphics settings
%
% MyGraphPrefs('on')
% MyGraphPrefs('off')

if strcmp('on', opt)
    
    set(0, 'DefaultAxesFontSize', 7);
    set(0, 'DefaultTextFontSize', 7);


    %     set(0, 'DefaultFigureColor', 'White')
    
    % linewidth
    %     set(0, 'DefaultLineLineWidth', 1);
    
    % figure color
    %     set(0, 'DefaultLineMarkerSize', 10);

    % tick direction (default 'in' , 'out')
    %     set(0, 'DefaultAxesTickDir', 'out')

    set(0, 'DefaultAxesColorOrder', [0 0 0])  % Force all plots to be black.

else
    
    set(0, 'DefaultAxesFontSize', 'remove');
    set(0, 'DefaultTextFontSize', 'remove');
    set(0, 'DefaultLineLineWidth', 'remove');
    
    colors = [
        0         0    1.0000
        1.0000         0         0
        0    1.0000         0
        0         0    0.1724
        1.0000    0.1034    0.7241
        ];
    
    set(0, 'DefaultAxesColorOrder', colors)
    
    %         set(0, 'DefaultLineMarkerSize', 'remove');
    % set(0,'DefaultFigureColor', 'remove')
    set(0, 'DefaultAxesTickDir', 'remove')
    
end

