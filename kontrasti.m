
%
% testailua kontrastin parantamisesta venytysalgoritmillä ja
% ekvalisointialgoritmllä
%

% Mikko Seppi
% 5.11.2020


clear all

%% a

%luetaan kuva
A = imread('lena_gray_512_lowcontrast.tif');
%alkuperäinen kuva
figure(1)
imshow(A)
title('Alkuperäinen')

%Histogrammi
figure(2)
imhist(A)
title('Histogrammi')

%% b
info = imfinfo('lena_gray_512_lowcontrast.tif');

minf = info.MinSampleValue; %Korkein intesiteettiarvo

maxf = info.MaxSampleValue; %Matalin intesiteettiarvo

maxg = 2^(info.BitDepth); %skaalauksen maksimiarvo

%suoritetaan venytysalgoritmi
g = ((A-minf)./(maxf-minf)).*maxg;

%kuvaaja
figure(3)
imshow(g)
title('venytys algoritmi')


%% c

L = 2^(info.BitDepth); %intesiteetti tasojen määrä

ceilA = ceil(A); %pyöristetään kuvan arvot ylöspäin

ln= zeros(max(ceilA(:)),1); % vektori arvojen määrälle

% Lasketaan kuinka monesti arvot esiintyvät ln vektoriin
for i = 1: length(ceilA(:,1))
    for j = 1: length(ceilA(1,:))
        ln(ceilA(i,j)) =  ln(ceilA(i,j)) + 1;
        
    end
end

% lasketaan intesiteettiarvojen todennäköisyydet
pn = ln./(length(ceilA(:,1))*length(ceilA(1,:))); 

%vektori T(k) arvoille
Tk = zeros(length(ln),1);

%Lasketaan siirtofunktiovektorin arvot
for k = 1:length(ln)
    x = 0;
    for n =1:k
        x = x + pn(n);
    end
    Tk(k) = ceil((L-1)*x);
    
end

%Suoritetaaan ekvalisointi sijoittamalla siirtofunktiovektorin arvot
%alkuperäiseen kuvaan

for i = 1: length(ceilA(:,1))
    for j = 1: length(ceilA(1,:))
        ceilA(i,j) =  Tk(ceilA(i,j));
        
    end
end

%Kuvaaja
figure(4)
imshow(ceilA)
title('Ekvalisointi algoritmi')










