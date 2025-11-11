% OUR5 motor shaft and bearing calculations

%% Constants
motor_torque = 250;  % Nm
chain = '#525';
% Sprockets
driving_teeth = 12;
driven_teeth = 47;
dist = 240.25;  % mm - center to center distance between sprockets
% Shaft
shaft_OD = 35;  % mm
shaft_length = 121;  % mm - between sprocket and motor
shaft_material = "4340";  % material of the shaft

%% Bearing radial force calculations
chain_force = get_chain_force(chain, driving_teeth, driven_teeth, dist, motor_torque);

%dimensions 'a' and 'b' set via inspection of the onshape assembly - rough
dist_a = 41.25;  % distance from sprocket to the near side bearing - see dimension 'a' in drawing (mm)
dist_b = 177.8;  % distance from sprocket to the far side bearing - see dimension 'b' in drawing (mm)

radial_force_a = ((dist_b)/(dist_b-dist_a))*chain_force;  % radial force experienced by Bearing A - the near side bearing (kN)
radial_force_b = ((dist_a)/(dist_b-dist_a))*chain_force;  % radial force experienced by Bearing B - the far side bearing (kN)

disp(['Radial force experienced by bearing A = ', num2str(radial_force_a), ' kN'])
disp(['Radial force experienced by bearing B = ', num2str(radial_force_b), ' kN'])

%% Shaft calculations
peak_bending_moment = dist_a * radial_force_a;  % Nm
[shaft_VM_stress, shaft_SF] = evaluate_motor_shaft(shaft_OD, shaft_length, peak_bending_moment, motor_torque, shaft_material);