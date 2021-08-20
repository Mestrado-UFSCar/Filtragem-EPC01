%main para o epc01 da semana01
clear all
clc all
close all
%carregando dados

imu_data = load('imuData.mat');

%data IMU

gyro = imu_data.g;
time = imu_data.t;

%tamanho do vetor de tempo para IMU e MAG
n = length(time);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%variaveis para filtro AVG
avg_gyro = zeros(3,n);

%variaveeis para filtro MOV
mov_gyro = zeros(3,n);

%variaveeis para LPF
low_gyro = zeros(3,n);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for k = 1:n
  
  avg_gyro(:,k) = AvgFilter(gyro(:,k));
  mov_gyro(:,k) = MovAvgFilter(gyro(:,k));
  low_gyro(:,k) = LPF(gyro(:,k));
  
end

cor = ['g','r','b'];
titulog = ["Gyro - X";"Gyro - Y";"Gyro - Z"];
titulog = cellstr(titulog);

figure 

for i = 1:3
  subplot(3,1,i)
  hold on
  plot(time,gyro(i,:), 'color', ([184, 184, 184]/255))
  plot(time, avg_gyro(i,:) , 'color',cor(i))
  xlabel('Time [sec]')
  ylabel('angular Vel. [rad/s]')
  legend('Measurement', 'Average')
  title(titulog(i))
  grid on
end

figure 

for i = 1:3
  subplot(3,1,i)
  hold on
  plot(time,gyro(i,:), 'color', ([184, 184, 184]/255))
  plot(time, mov_gyro(i,:) , 'color',cor(i))
  xlabel('Time [sec]')
  ylabel('angular Vel. [rad/s]')
  legend('Measurement', 'Moving average')
  title(titulog(i))
  grid on
end

figure 

for i = 1:3
  subplot(3,1,i)
  hold on
  plot(time,gyro(i,:), 'color', ([184, 184, 184]/255))
  plot(time, low_gyro(i,:) , 'color',cor(i))
  xlabel('Time [sec]')
  ylabel('angular Vel. [rad/s]')
  legend('Measurement', 'Low-Pass')
  title(titulog(i))
  grid on
end