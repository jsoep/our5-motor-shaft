function chain_force = get_chain_force(chain, teeth, motor_torque)
% get_chain_force Calculate the maximum chain force based on the number of teeth on the driving sprocket.
%   chain: string, chain size (e.g., '#525')
%   teeth: integer, number of teeth on the driving sprocket
%   motor_torque: motor torque applied to the system (N*m)

% Define chain pitch lookup table
chain_sizes = {'#35', '#420', '#520', '#525', '#530', '#428'};
chain_pitches = [9.525, 12.7, 15.875, 15.875, 15.875, 12.7];

% Find pitch for given chain
idx = find(strcmp(chain, chain_sizes));
if isempty(idx)
    error('Unknown chain size: %s', chain);
end
pitch = chain_pitches(idx);

driving_sprocket_diameter = pitch / sind(180/teeth); % in mm
chain_force = 2000 * motor_torque / driving_sprocket_diameter; % in N

end