function [VM_stress, safety_factor] = SplinedShaft_Function(Shaft_OD)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
% OUR5 motor shaft sizing

%% Constants

% MOTOR DATA
% YASA P400RS 12T
Peak_Torque = 250;  % (Nm)
Peak_BendingMoment = 1440; % (Nm)

% SHAFT DIMENSIONS
% shaft is a solid cylinder
% Spline dimensions for reference:
% d_major = 35.59;  % (mm)
% d_minor = 33.38;  % (mm)
%Shaft_OD = 34e-3;  % shaft diameter (m)
L = 0.2;  % shaft length (m)

R = Shaft_OD/2;  % shaft radius (m)

% MATERIAL PROPERTIES 
% (ultra high strength steel from HLT)
G = 80e9;  % shear modulus of material (Pa)
Sy = 1600e6;  % yield strength of material (Pa)

%% Calculations

%yield_shear_stress = Sy/sqrt(3);  % von Mises max shear stress in pure shear yielding
%disp(['Yield Shear Stress of shaft material = ', num2str(yield_shear_stress/1e6), ' MPa'])

%Torsion
J = pi/32 * (Shaft_OD^4);  % polar moment of inertia (m^4) for solid circular shaft
I = pi/64 * (Shaft_OD^4); %second moment for bending (m^4) for solid circular shaft
max_shear_stress = ((Peak_Torque * R)/J);  % shear stress at outer surface (max) in Pa
disp(['Max Shear Stress in shaft = ',num2str(max_shear_stress/1e6), ' MPa'])
%Bending
max_bending_stress = ((Peak_BendingMoment*R)/I);
disp(['Max Bending Stress in shaft = ',num2str(max_bending_stress/1e6), ' MPa'])
%Von misses
VM_stress = sqrt((max_bending_stress^2) + (3*(max_shear_stress)^2));
disp(['Von Misses Stress = ',num2str(VM_stress/1e6), ' MPa'])
%Safety Factor
safety_factor = Sy/VM_stress;
disp(['Factor of Safety combined Bending and Torsion = ',num2str(safety_factor)])

twist_angle_rad = ((Peak_Torque*L)/(J*G));
twist_angle_deg = twist_angle_rad * 180/pi;
disp(['Twist angle under peak torque = ', num2str(twist_angle_deg), ' deg'])


% Safety factor calculation (based on max shear stress)
%safety_factor = yield_shear_stress / max_shear_stress;
%disp(['Safety factor (shear) = ', num2str(safety_factor)])
end