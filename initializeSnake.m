function [x, y] = initializeSnake(I)

% Show figure
figure(1), hold off, imshow(I), axis image;
[imh, imw, ~] = size(I);
sx = [];
sy = [];

%same code as provided for poisson blending mask initialization
while 1
    
    figure(1)
    [x, y, b] = ginput(1);
    if b=='q' || b=='Q'
        break;
    end
    if x<2
        x=2;
    end
    if y<2
        y=2;
    end
    if x>imw-1
        x=imw-1;
    end
    if y>imh-1
        y=imh-1;
    end
    
%Adds points coord 
    sx(end+1) = x;
    sy(end+1) = y;
    hold on, plot(sx, sy, '*');  
end

%Ensures snake loops back to start
sx(end+1) = sx(:,1);
sy(end+1) = sy(:,1);

%Interpolate between points using spline fnc(600 points)
t = linspace(0,1,size(sx,2));
tt = linspace(0,1,600);
xx = spline(t,sx,tt);
yy = spline(t,sy,tt);

%Check for interpolation error
xx(isnan(xx))=1;
yy(isnan(yy))=1;

%Clamp Interpolated points
xx(xx<1) = 1;
xx(xx>imw) = imw-1;
yy(yy<1) = 1;
yy(yy>imh) = imh-1;
hold on, plot(xx,yy, 'b');
x = xx;
y = yy;
end

