
%
% Testailua 2d-suodattimilla
% 
%

% Mikko Seppi
% 5.11.2020




A = imread('cameraman.tif');

info = imfinfo('cameraman.tif');

%% a)

%konvoluutiomaski, joka laskee kahden viereisen pikselin derivaatan
H1 = [1,0,-1;0,0,0;-1,0,1];

%kuva konvoluutio maskin kanssa
tulos1 = conv2(A,H1);

%Normalisointi
tulos1 = (tulos1./max(tulos1)).*info.MaxSampleValue;

figure(1)
imshow(tulos1)
title('a kohta')

%% b)

%Laplace-maski
H2 = 1/8.*[-1,-1,-1;-1,8,-1;-1,-1,-1];


%kuva konvoluutio maskin kanssa
tulos2 = conv2(A,H2);

%Normalisointi
tulos2 = (tulos2./max(tulos2)).*info.MaxSampleValue;

figure(2)
imshow(tulos2)
title('b kohta')
%muutetaan maskia siten kuvan ja kuvan, jossa reunat on tunnistettu,
%suhdetta voidaan muuttaa

%% Suodatetaan kuva k:n eri arvoilla

k= 2; %skalaariparametri
Hk1 = k/8.*[-1,-1,-1;-1,8,-1;-1,-1,-1] + [0,0,0;0,1,0;0,0,0];

%kuva konvoluutio maskin kanssa
tulosHk1 = conv2(A,Hk1);

%Normalisointi
tulosHk1 = (tulosHk1./max(tulosHk1)).*info.MaxSampleValue;

figure(3)
subplot(2,2,1)
imshow(tulosHk1)
title('k=2')



k=16;
Hk2 = k/8.*[-1,-1,-1;-1,8,-1;-1,-1,-1] + [0,0,0;0,1,0;0,0,0];

%kuva konvoluutio maskin kanssa
tulosHk2 = conv2(A,Hk2);

%Normalisointi
tulosHk2 = (tulosHk2./max(tulosHk2)).*info.MaxSampleValue;

subplot(2,2,2)
imshow(tulosHk2)
title('k=16')

k=32;
Hk3 = k/8.*[-1,-1,-1;-1,8,-1;-1,-1,-1] + [0,0,0;0,1,0;0,0,0];

%kuva konvoluutio maskin kanssa
tulosHk3 = conv2(A,Hk3);

%Normalisointi
tulosHk3 = (tulosHk3./max(tulosHk3)).*info.MaxSampleValue;


subplot(2,2,3)
imshow(tulosHk3)
title('k=34')

k=200;
Hk4 = k/8.*[-1,-1,-1;-1,8,-1;-1,-1,-1] + [0,0,0;0,1,0;0,0,0];

%kuva konvoluutio maskin kanssa
tulosHk4 = conv2(A,Hk4);

%Normalisointi
tulosHk4 = (tulosHk4./max(tulosHk4)).*info.MaxSampleValue;


subplot(2,2,4)
imshow(tulosHk4)
title('k=64')

%% c)

%lis‰t‰‰n kuvaan kohinaa
noiseim = imnoise(A,'gaussian');

figure(4)
imshow(noiseim)
title('Kohinainen kuva')

%suodatetaan kohina kuvasta
nonoise = medfilt2(noiseim);

figure(5)
imshow(nonoise)
title('Kohina poistettu')








