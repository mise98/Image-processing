
%
% testailua kontrastin parantamisesta venytysalgoritmill� ja
% ekvalisointialgoritmll�
%

% Mikko Seppi
% 5.11.2020


clear all

%% a

%luetaan kuva
A = imread('lena_gray_512_lowcontrast.tif');
%alkuper�inen kuva
figure(1)
imshow(A)
title('Alkuper�inen')

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

L = 2^(info.BitDepth); %intesiteetti tasojen m��r�

ceilA = ceil(A); %py�ristet��n kuvan arvot yl�sp�in

ln= zeros(max(ceilA(:)),1); % vektori arvojen m��r�lle

% Lasketaan kuinka monesti arvot esiintyv�t ln vektoriin
for i = 1: length(ceilA(:,1))
    for j = 1: length(ceilA(1,:))
        ln(ceilA(i,j)) =  ln(ceilA(i,j)) + 1;
        
    end
end

% lasketaan intesiteettiarvojen todenn�k�isyydet
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
%alkuper�iseen kuvaan

for i = 1: length(ceilA(:,1))
    for j = 1: length(ceilA(1,:))
        ceilA(i,j) =  Tk(ceilA(i,j));
        
    end
end

%Kuvaaja
figure(4)
imshow(ceilA)
title('Ekvalisointi algoritmi')










