function o = calculate_cone_angle_list(p,o,idx)
%% will_eulers_angle_list
% A function for generating a list of evenly sampled Euler angles. 
%
% The search type can either be 'coarse' or 'complete', where coarse
% results in a search equivalent to DYNAMO's seach algorithm. Essentially,
% spacing around each theta-ring is equal to the spacing between the ring
% and the pole rather than the spacing between theta increments. The
% default search is complete.
%
% v1: WW 11-2017
% v2: WW 01-2018 Small updates
%
% WW 01-2018

% % % DEBUG
% angincr=2;
% angiter=3;
% phi_angincr=2;
% phi_angiter=3;


%% Calculate angles

% Calculate cone angles
cone_angles = calculate_cone_angles(p(idx).angincr, p(idx).angiter, p(idx).cone_search_type);
n_cones = size(cone_angles,2);

% Calculate phi angles
phi_range = p(idx).phi_angincr*p(idx).phi_angiter;
phi_array = -phi_range:p(idx).phi_angincr:phi_range;
if isempty(phi_array)
    phi_array = 0;
end
n_phi = numel(phi_array);

% Generate triples
n_angles = n_cones*n_phi;
o.anglist = cat(1,reshape(repmat(phi_array,[n_cones,1]),[1,n_angles]),repmat(cone_angles,[1,n_phi]));
o.n_ang = size(o.anglist,2);

% Convert search angles to quaternions
o.q_ang = cell(o.n_ang,1);
for i = 1:o.n_ang
    o.q_ang{i} = will_euler2quaternion(o.anglist(1,i),o.anglist(2,i),o.anglist(3,i));  % Convert cone angle to quaternion 
end


