function [Eext] = getExternalEnergy(I,Wline,Wedge,Wterm)

% Eline
Eline = I;
% Eedge
[Gmag,Gdir] = imgradient(I);
Eedge = -Gmag;
% Eterm
x_der = [0 0 0; 0 -1 1; 0 0 0];
xx_der = [0 0 0; 1 -2 1; 0 0 0];
y_der = [0 0 0; 0 -1 0; 0 1 0];
yy_der = [0 1 0; 0 -2 0; 0 1 0];
xy_der = [0 -1 1; 0 1 -1; 0 0 0];

Cx = conv2(I, x_der, 'same');
Cy = conv2(I, y_der, 'same');
Cxx = conv2(I, xx_der, 'same');
Cyy = conv2(I, yy_der, 'same');
Cxy = conv2(I, xy_der, 'same');

Eterm = ((Cyy.*Cx.^2)-(2.*Cxy.*Cx.*Cy)+(Cxx.*Cy.^2))./((1+Cx.^2+Cy.^2).^(3/2));
% Eext
Eext = Wline.*Eline + Wedge.*Eedge + Wterm.*Eterm;

end

