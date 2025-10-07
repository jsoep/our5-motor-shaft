function chain_force = get_chain_force(chain, driving_teeth, driven_teeth, dist, motor_torque)
% get_chain_force Calculate the maximum chain force based on the number of teeth on the driving sprocket.
%   chain: string, chain size (e.g., '#525')
%   driving_teeth: integer, number of teeth on the driving sprocket
%   driven_teeth: integer, number of teeth on the driven sprocket
%   dist: distance between sprockets (mm)
%   motor_torque: motor torque (N*m)

driving_sprocket_diameter = get_sprocket_diameter(chain, driving_teeth);
driven_sprocket_diameter = get_sprocket_diameter(chain, driven_teeth);
chain_tension = 2 * motor_torque / driving_sprocket_diameter;  % kN
disp(['chain tension = ', num2str(chain_tension), ' kN']);

% Calculate the angle of the chain above the horizon (degrees)
delta_radius = (driven_sprocket_diameter - driving_sprocket_diameter) / 2;
angle_above_horizon = atand(delta_radius / dist);
chain_force = chain_tension * cosd(angle_above_horizon);  % kN
disp(['chain force = ', num2str(chain_force), ' kN']);
end