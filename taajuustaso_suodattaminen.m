
%
% Testailua taajuustasossa suodattamisesta
% 
%

% Mikko Seppi
% 5.11.2020


clear all

%luetaan kuva
A = imread('cameraman.tif');

info = imfinfo('cameraman.tif');

%% a

%Muunnetaan kuva taajuustasoon ja siirretään nollataajuinen
%komponentti keskelle
fftA = fftshift(fft2(A));

%ideaalinen alipäästösuodatin rajataajuudella fc = 40
fc = 40;
[ x , y ]=meshgrid( -256:255 , -256:255 );
z=sqrt ( x.^2+y.^2 ) ;
H_ideal=z< fc ;

%suodatetaan kuva
suodatettu_tt = fftA.*H_ideal;

%muutetaan takaisin aika tasoon
suodatettu_at = ifft2(ifftshift(suodatettu_tt));

%tehdään kuvaajat

figure(1)

%alkuperäisen kuvaaja
subplot(2,2,1)
imshow(A)
title('Alkuperäinen kuva')

%alkuperäisen spektrin kuvaaja
subplot(2,2,2)
imshow(( mat2gray ( log (1 + abs (fftA) ) ) ));
title('Alkuperäisen spektri')

%suodetettu kuva
subplot(2,2,3)
imshow(uint8(suodatettu_at))
title('Suodatettu kuva')

%suodatetun spketrin kuvaaja
subplot(2,2,4)
imshow(( mat2gray ( log (1 + abs (suodatettu_tt) ) ) ));
title('Suodatetun spektri')

%% b

%implementoidaan 4. asteen Butterworth-alipäästösuodatin rajataajuudella
%fc=40

fc = 40; %rajataajuus

n = 4; %asteluku

[ x , y ]=meshgrid( -256:255 , -256:255 );

z = 1./(1+((((x.^2+y.^2).^(1/2))./fc)).^(2*n));

H_butter = z<fc;%valmis suodatin

%suodatus

%suodatetaan kuva
suodatettu_tt2 = fftA.*H_butter;

%muutetaan takaisin aika tasoon
suodatettu_at2 = ifft2(ifftshift(suodatettu_tt2));


%kuvaajat

figure(2)

%alkuperäisen kuvaaja
subplot(2,2,1)
imshow(A)
title('Alkuperäinen kuva')

%alkuperäisen spektrin kuvaaja
subplot(2,2,2)
imshow(( mat2gray ( log (1 + abs (fftA) ) ) ));
title('Alkuperäisen spektri')

%suodetettu kuva
subplot(2,2,3)
imshow(uint8(suodatettu_at2))
title('Suodatettu kuva')

%suodatetun spketrin kuvaaja
subplot(2,2,4)
imshow(( mat2gray ( log (1 + abs (suodatettu_tt2) ) ) ));
title('Suodatetun spektri')













