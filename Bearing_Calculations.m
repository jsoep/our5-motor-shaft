% OUR 5 Motor Bearing Calculations

chain_force = get_chain_force('#525', 12, 250);
disp(['Maximum chain force = ', num2str(chain_force/1000), ' kN'])

%dimensions 'a' and 'b' set via inspection of the onshape assembly - rough
dist_a = 49.75e-3; %distance from sprocket to the near side bearing - see dimension 'a' in drawing (m)
dist_b = 156.4e-3; %distance from sprocket to the far side bearing - see dimension 'b' in drawing (m)

radial_force_a = ((dist_b)/(dist_b-dist_a))*chain_force; %The radial force experienced by Bearing A - the near side bearing (N)
radial_force_b = ((dist_a)/(dist_b-dist_a))*chain_force; %The radial force experienced by Bearing B - the far side bearing (N)

disp(['Radial force experienced by bearing A = ', num2str(radial_force_a/1000), ' kN'])
disp(['Radial force experienced by bearing B = ', num2str(radial_force_b/1000), ' kN'])

%% Basic Dynamic Loading Rating

P = max(radial_force_a,radial_force_b) * 0.5; %the equivalent dynamic bearing load - approx 50% of max (N)
n = 4000; % rotational speed the bearing will most commonly be ran at (rpm)
L = 100; %Life rating of bearing (hours) - where 90% of bearings fail
p = 3; %Life exponent (3 for ball bearings)
C = P * ((60*n*L)/10^6)^(1/p); %Basic Dynamic Load Rating (N)
disp(['Required basic dynamic load rating of bearing = ', num2str(C/1000), ' kN'])

%% Chosen Bearing
%Rated_RadialForce = 20000; %What is the bearing radial force rated at (N)
Rated_ID = 35e-3;

%RadialForce_SF = Rated_RadialForce/radial_force_a; %The safety factor between what radial force the bearing is rated for and how much it is experiencing
%disp(['Bearing radial force factor of safety = ', num2str(RadialForce_SF)])

[Max_ShaftVMStress, Shaft_SF] = evaluate_motor_shaft(Rated_ID);
%disp(['Max Shaft Shear Stress = ', num2str(Max_ShaftShearStress/1e6), 'MPa'])
%disp(['Shaft Safety Factor = ', num2str(Shaft_SF)])
