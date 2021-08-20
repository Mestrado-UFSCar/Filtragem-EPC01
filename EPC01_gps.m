%main para o epc01 da semana01
clear all
clc all
close all

%carregando dados
gps_data = load('gpsData.mat');

%data GPS
time = gps_data.t;
altitude = gps_data.altitude;
latitude = gps_data.latitude;
longitude = gps_data.longitude;
gps = [altitude; altitude; longitude];

%tamanho do vetor de tempo para gpsData
m = length(gps_data.t);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%variaveis para filtro AVG
avg_gps = zeros(3,m);

%variaveeis para filtro MOV
mov_gps = zeros(3,m);

%variaveeis para LPF
low_gps = zeros(3,m);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for k = 1:m
  
  avg_gps(:,k) = AvgFilter(gps(:,k));
  mov_gps(:,k) = MovAvgFilter(gps(:,k));
  low_gps(:,k) = LPF(gps(:,k));
  
end

cor = ['g','r','b'];
titulogps = ["GPS - X";"GPS - Y";"GPS - Z"];
titulogps = cellstr(titulogps);

figure 

for i = 1:3
  subplot(3,1,i)
  hold on
  plot(time(1:m),gps(i,:), 'color', ([184, 184, 184]/255))
  plot(time(1:m), avg_gps(i,:) , 'color',cor(i))
  xlabel('Time [sec]')
  ylabel('Value')
  legend('Measurement', 'Average')
  title(titulogps(i))
  grid on
end

figure 

for i = 1:3
  subplot(3,1,i)
  hold on
  plot(time(1:m),gps(i,:), 'color', ([184, 184, 184]/255))
  plot(time(1:m), mov_gps(i,:) , 'color',cor(i))
  xlabel('Time [sec]')
  ylabel('Value')
  legend('Measurement', 'Moving Average')
  title(titulogps(i))
  grid on
end

figure 

for i = 1:3
  subplot(3,1,i)
  hold on
  plot(time(1:m),gps(i,:), 'color', ([184, 184, 184]/255))
  plot(time(1:m), low_gps(i,:) , 'color',cor(i))
  xlabel('Time [sec]')
  ylabel('Value')
  legend('Measurement', 'Low-Pass')
  title(titulogps(i))
  grid on
end