clc; clear; close all;

% --- 1. Load and Process Airfoil Data ---
filename = 'NACA63415.dat';
if ~isfile(filename)
    error('File %s not found.', filename);
end

data = importdata(filename, ' ', 1);
coords = data.data;

% Separate Upper and Lower Surfaces
[~, le_idx] = min(coords(:, 1));
upper_surf = coords(1:le_idx, :);
lower_surf = coords(le_idx:end, :);

% Prepare X and Z vectors (Flip upper so X is increasing)
u_x = flipud(upper_surf(:, 1));
u_z = flipud(upper_surf(:, 2));
l_x = lower_surf(:, 1);
l_z = lower_surf(:, 2);

% --- 2. User Input Section ---
% Define the Wing Box boundaries
x_start = 0.20; % Front Spar
x_end   = 0.75; % Rear Spar

fprintf('------------------------------------------------\n');
fprintf('Wing Box Configuration (0.20c to 0.75c)\n');
fprintf('------------------------------------------------\n');

% Ask user for N
n = input('How many points (spars + stringers) do you want? ');

% Check to ensure at least 2 points (Front & Rear spar)
if n < 2
    n = 2;
    fprintf('Warning: Setting n=2 (minimum for Front and Rear spars).\n');
end

% --- 3. Calculate Locations ---
% Create n evenly spaced points between start and end
x_locations = linspace(x_start, x_end, n);

% Interpolate to find Top and Bottom Z for all points at once
z_tops = interp1(u_x, u_z, x_locations, 'linear');
z_bots = interp1(l_x, l_z, x_locations, 'linear');

% --- 4. Display Results ---
fprintf('\nRESULTS:\n');
fprintf('%-15s %-10s %-15s %-15s %-10s\n', 'Point Name', 'X Loc', 'Top Z', 'Bottom Z', 'Height');
fprintf('%s\n', repmat('-', 1, 65));

for i = 1:n
    % Determine the name of the point
    if i == 1
        name = 'Front Spar';
    elseif i == n
        name = 'Rear Spar';
    else
        name = sprintf('Stringer %d', i-1);
    end
    
    current_x = x_locations(i);
    top = z_tops(i);
    bot = z_bots(i);
    thickness = top - bot;
    
    fprintf('%-15s %-10.4f %-15.4f %-15.4f %-10.4f\n', name, current_x, top, bot, thickness);
end

% --- 5. Visualization ---
figure('Name', 'Wing Box Stringer Locations');
hold on; grid on; axis equal;

% Plot Airfoil
plot(coords(:,1), coords(:,2), 'k', 'LineWidth', 1.5);

% Plot the points and vertical lines
for i = 1:n
    x = x_locations(i);
    zt = z_tops(i);
    zb = z_bots(i);
    
    % Draw vertical line (stringer/spar)
    line([x x], [zb zt], 'Color', 'b', 'LineWidth', 1);
    
    % Plot red dots at the intersection points
    plot(x, zt, 'ro', 'MarkerSize', 6, 'MarkerFaceColor', 'r');
    plot(x, zb, 'ro', 'MarkerSize', 6, 'MarkerFaceColor', 'r');
end

title(sprintf('NACA 63-415 with %d Structural Elements', n));
xlabel('Chord Position (x/c)');
ylabel('Thickness (z/c)');
legend('Airfoil Surface', 'Structural Elements');