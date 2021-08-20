%main para o epc01 da semana01
clear all
clc all
close all
%carregando dados

imu_data = load('imuData.mat');

%data IMU
accel = imu_data.a;
time = imu_data.t;

%tamanho do vetor de tempo para IMU e MAG
n = length(time);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%variaveis para filtro AVG
avg_accel = zeros(3,n);

%variaveeis para filtro MOV
mov_accel = zeros(3,n);

%variaveeis para LPF
low_accel = zeros(3,n);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for k = 1:n
  
  avg_accel(:,k) = AvgFilter(accel(:,k));
  mov_accel(:,k) = MovAvgFilter(accel(:,k));
  low_accel(:,k) = LPF(accel(:,k));
  
end

%%plot accel 

cor = ['g','r','b'];
tituloa = ["Accel - X";"Accel - Y";"Accel - Z"];
tituloa = cellstr(tituloa);
figure

for i = 1:3
  subplot(3,1,i)
  hold on
  plot(time,accel(i,:), 'color', ([184, 184, 184]/255))
  plot(time, avg_accel(i,:) , 'color',cor(i))
  xlabel('Time [sec]')
  ylabel('Linear Accel. [m/s^2]')
  legend('Measurement', 'Average')
  title(tituloa(i))
  grid on
end

figure

for i = 1:3
  subplot(3,1,i)
  hold on
  plot(time,accel(i,:), 'color', ([184, 184, 184]/255))
  plot(time, mov_accel(i,:) , 'color',cor(i))
  xlabel('Time [sec]')
  ylabel('Linear Accel. [m/s^2]')
  legend('Measurement', 'Moving average')
  title(tituloa(i))
  grid on
end

figure

for i = 1:3
  subplot(3,1,i)
  hold on
  plot(time,accel(i,:), 'color', ([184, 184, 184]/255))
  plot(time, low_accel(i,:) , 'color',cor(i))
  xlabel('Time [sec]')
  ylabel('Linear Accel. [m/s^2]')
  legend('Measurement', 'Low-Pass')
  title(tituloa(i))
  grid on
end


