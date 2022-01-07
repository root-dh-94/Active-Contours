clear all;

% Parameters (play around with different images and different parameters)
N = 200;
alpha =3;
beta = .2;
gamma = 0.1;
kappa = 0.15;
Wline = .7;
Wedge = 1;
Wterm = 0.9;
sigma = .5;


% Load image
I = imread('images/square.jpg');
if (ndims(I) == 3)
    I = rgb2gray(I);
end

% Initialize the snake
[x, y] = initializeSnake(I);

% Calculate external energy
%im2double normalizes img
I_smooth = im2double(imgaussfilt(I, sigma));
Eext = getExternalEnergy(I_smooth,Wline,Wedge,Wterm);

% Calculate matrix A^-1 for the iteration
Ainv = getInternalEnergyMatrix(size(x,2), alpha, beta, gamma);

% Iterate and update positions
displaySteps = floor(N/10);
for i=1:N
    % Iterate
    [x,y] = iterate(Ainv, x, y, Eext, gamma, kappa);
   

    % Plot intermediate result
    imshow(I); 
    hold on;
    plot([x x(1)], [y y(1)], 'r');
        
    % Display step
    if(mod(i,displaySteps)==0)
        fprintf('%d/%d iterations\n',i,N);
    end
    
    pause(.00004)
end
 
if(displaySteps ~= N)
    fprintf('%d/%d iterations\n',N,N);
end