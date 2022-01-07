function [newX, newY] = iterate(Ainv, x, y, Eext, gamma, kappa)

%Get forces due to external energy vector field
[Gx,Gy] = imgradientxy(Eext);

%Iterpolate foce values from pixel indeces to x,y coords
Fx = interp2(Gx,x,y);
Fy = interp2(Gy,x,y);

%To check for interpolation error
Fx(isnan(Fx))=0;
Fy(isnan(Fy))=0;

%Calculate new coordinates
newX= Ainv*(gamma.*x'+kappa.*Fx');
newY= Ainv*(gamma.*y'+kappa.*Fy');
   
%Clamp to image size   
newX(newX<1) = 1;
newX(newX>size(Eext,2)) = size(Eext,2)-1;
newY(newY<1) = 1;
newY(newY>size(Eext,1)) = size(Eext,1)-1;

newX = newX';
newY = newY';
end

