function [VM_stress, safety_factor] = evaluate_motor_shaft(shaft_OD, shaft_length, peak_bending_moment, motor_torque)
% evaluate_motor_shaft Evaluate the motor shaft for combined bending and torsion.
%   shaft_OD: outer diameter of the shaft (mm)
%   shaft_length: length of the shaft between sprocket and motor (mm)
%   motor_torque: torque applied by the motor (N*m)

%% Constants

% SHAFT DIMENSIONS
% shaft is a solid cylinder, diameter is input of function
shaft_OD = shaft_OD / 1000;  % convert mm to m
shaft_length = shaft_length / 1000;  % convert mm to m
R = shaft_OD/2;  % shaft radius (m)

% MATERIAL PROPERTIES 
% 300M steel (aka ultra high strength steel in HLT)
% source: https://asm.matweb.com/search/SpecificMaterial.asp?bassnum=MS300M
G = 80e9;  % shear modulus of material (Pa)
Sy = 1550e6;  % yield strength of material (Pa)

%% Calculations

%yield_shear_stress = Sy/sqrt(3);  % von Mises max shear stress in pure shear yielding
%disp(['Yield Shear Stress of shaft material = ', num2str(yield_shear_stress/1e6), ' MPa'])

%Torsion
J = pi/32 * (shaft_OD^4);  % polar moment of inertia (m^4) for solid circular shaft
I = pi/64 * (shaft_OD^4); %second moment for bending (m^4) for solid circular shaft
max_shear_stress = ((motor_torque * R)/J);  % shear stress at outer surface (max) in Pa
disp(['Max Shear Stress in shaft = ',num2str(max_shear_stress/1e6), ' MPa'])
% Bending
max_bending_stress = ((peak_bending_moment*R)/I);
disp(['Max Bending Stress in shaft = ',num2str(max_bending_stress/1e6), ' MPa'])
% Von misses
VM_stress = sqrt((max_bending_stress^2) + (3*(max_shear_stress)^2));
disp(['Von Misses Stress = ',num2str(VM_stress/1e6), ' MPa'])
% Safety Factor
safety_factor = Sy/VM_stress;
disp(['Safety factor for combined bending and torsion = ',num2str(safety_factor)])

twist_angle_rad = ((motor_torque*shaft_length)/(J*G));
twist_angle_deg = twist_angle_rad * 180/pi;
disp(['Twist angle under peak torque = ', num2str(twist_angle_deg), ' deg'])


% Safety factor calculation (based on max shear stress)
%safety_factor = yield_shear_stress / max_shear_stress;
%disp(['Safety factor (shear) = ', num2str(safety_factor)])
end