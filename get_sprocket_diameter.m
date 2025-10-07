function sprocket_diameter = get_sprocket_diameter(chain, teeth)
% get_sprocket_diameter Calculate the diameter of the driving sprocket based on the chain size and number of teeth.
%   chain: string, chain size (e.g., '#525')
%   teeth: integer, number of teeth on the sprocket

% Define chain pitch lookup table
chain_sizes = {'#35', '#420', '#520', '#525', '#530', '#428'};
chain_pitches = [9.525, 12.7, 15.875, 15.875, 15.875, 12.7];

% Find pitch for given chain
idx = find(strcmp(chain, chain_sizes));
if isempty(idx)
    error('Unknown chain size: %s', chain);
end
pitch = chain_pitches(idx);

sprocket_diameter = pitch / sind(180/teeth);  % mm

end