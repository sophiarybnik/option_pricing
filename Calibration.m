clear;
clc;
x0_1 = [0.2; 0.0; 0.0];
[x1, resnorm1] = calibrate_parameters(x0_1)

x0_2 = [0.2; 0.1; 0.01];
[x2, resnorm2] = calibrate_parameters(x0_2)





