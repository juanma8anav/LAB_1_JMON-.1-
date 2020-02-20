
% Limpieza
clear all; 
close all;
clc;

%cargar datos
data = xlsread('consumo.xlsx','Worksheet','A2:B285'); %Carga los datos del archivo

nrez = 3;
temp = [];

for k = 0:nrez
    temp(:,k+1) = data(nrez+1-k:end-k);
end

Y = temp(:,1)'; % Se transponepor requerimiento del toolbox
X = temp(:,1)';

ndat = round(0.9*size(Y,2)); % redondeo
Xtrain = X(:,1:ndat-10);
Ytrain = Y(:,1:ndat-10);

%Creación de la red multicapa neuronal
red = feedforwardnet([6 6 6 6 6 6]);

%Definir los parámetros de entrenamiento
red.trainFcn = "trainlm" %lm = entrenar por levenberg-marquart, gs es gradiente descendente
%Traingd entrenar con gradiente descendente

red = train(red,Xtrain, Ytrain); %Que red, que datos de entrada, uy que datos de salida

%Simulación
Yg = red(X);

%Gráficado (No necesaria)

plot(1:size(Y,2),Y,"-",1:size(Yg,2),Yg,"r--")

%perform para calcular error
%perform(red,Y,Yg)
%mape
mape1= abs(Y(end-3)-Yg(end-3))/abs(Y(end-3));
mape2= abs(Y(end-2)-Yg(end-2))/abs(Y(end-2));
mape3= abs(Y(end-1)-Yg(end-1))/abs(Y(end-1));
mape4= abs(Y(end-0)-Yg(end-0))/abs(Y(end-0));
%mape5= abs(Y(end-0)-Yg(end-0))/abs(Y(end-0));
MAPE = 0.25*(mape1+mape2+mape3+mape4);
disp("Mape de:")
MAPE
%MAPE = 0.2*(mape1+mape2+mape3+mape4+mape5)

