%main para o epc01 da semana01
clear all
clc all
close all
%carregando dados

mag_data = load('magData.mat');
imu_data = load('imuData.mat');

%data IMU

time = imu_data.t;

%data MAG
mag = mag_data.m;

%tamanho do vetor de tempo para IMU e MAG
n = length(time);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%variaveis para filtro AVG
avg_mag = zeros(3,n-1);

%variaveeis para filtro MOV
mov_mag = zeros(3,n-1);


%variaveeis para LPF
low_mag = zeros(3,n-1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for k = 1:n-1
  
  avg_mag(:,k) = AvgFilter(mag(:,k));
  mov_mag(:,k) = MovAvgFilter(mag(:,k));
  low_mag(:,k) = LPF(mag(:,k));
  
end


cor = ['g','r','b'];
titulom = ["Mag - X";"Mag - Y";"Mag - Z"];
titulom = cellstr(titulom);

figure 

for i = 1:3
  subplot(3,1,i)
  hold on
  plot(time(1:n-1),mag(i,:), 'color', ([184, 184, 184]/255))
  plot(time(1:n-1), avg_mag(i,:) , 'color',cor(i))
  xlabel('Time [sec]')
  ylabel('Value')
  legend('Measurement', 'Average')
  title(titulom(i))
  grid on
end

figure 

for i = 1:3
  subplot(3,1,i)
  hold on
  plot(time(1:n-1),mag(i,:), 'color', ([184, 184, 184]/255))
  plot(time(1:n-1), mov_mag(i,:) , 'color',cor(i))
  xlabel('Time [sec]')
  ylabel('Value')
  legend('Measurement', 'Moving Average')
  title(titulom(i))
  grid on
end

figure 

for i = 1:3
  subplot(3,1,i)
  hold on
  plot(time(1:n-1),mag(i,:), 'color', ([184, 184, 184]/255))
  plot(time(1:n-1), low_mag(i,:) , 'color',cor(i))
  xlabel('Time [sec]')
  ylabel('Value')
  legend('Measurement', 'Low-Pass')
  title(titulom(i))
  grid on
end
