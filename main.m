clear;

lena = imread('lena.png');
lenaDouble = double(lena);

figure
imshow(lena)
title('Original Picture')


sigmas = [2 8 16];
figure;

for i=1:length(sigmas)

    % Step 1
    % Filter the image by Gaussian lowpass filter
    N = 25;
    [X, Y] = meshgrid(-N/2:N/2-1, -N/2:N/2-1);
    G = 1/(2*pi*sigmas(i)^2)*exp(-(X.^2 + Y.^2)/(2*sigmas(i)^2));
    G = G/sum(G(:));

    bluredImage = (conv2(lenaDouble, G, 'same'));
    subplot(3,4,4*(i-1)+1); 
    imshow(uint8(bluredImage))
    title('Blurred Picture')


    % Filter image with Laplacian filter
    H = [-1 1; 1 -1];
    laplacian = conv2(bluredImage, H, 'same');
    logImage = laplacian;
    logImage(abs(laplacian) < .04*max(laplacian(:))) = 128;

    subplot(3,4,4*(i-1)+2); 
    imshow(uint8(logImage))
    title('2(a)')

    
    edgeImage = zeros(size(bluredImage));
    edgeImage(laplacian > 0) = 255;
    subplot(3,4,4*(i-1)+3); 
    imshow(uint8(edgeImage))
    title('2(b)')


    zeroImage = zeros(size(bluredImage));
    zeroImage(abs(laplacian) > .04*max(laplacian(:))) = 255;
    subplot(3,4,4*(i-1)+4); 
    imshow(uint8(zeroImage));
    title('2(c)')
end
