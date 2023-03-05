% Define the length of the two links
L1 = 5;
L2 = 10;

% Define the minimum and maximum angle limits for each joint
theta1_min = 0;
theta1_max = 2*pi;
theta2_min = 0;
theta2_max = 2*pi;

% Define the resolution of the C-Space
resolution = 0.01;

% Define the obstacles (shape, size, position, and color)
obstacle1 = struct('shape', 'square', 'size', [0.5, 0.5], 'position', [1, 1], 'color', 'r');
obstacle2 = struct('shape', 'triangle', 'size', [0.5, 0.5], 'position', [-1, -1], 'color', 'g');
obstacle3 = struct('shape', 'circle', 'size', 0.5, 'position', [0, 0], 'color', 'b');
obstacles = [obstacle1, obstacle2, obstacle3];

% Create a 2D grid to represent the C-Space
theta1_range = theta1_min:resolution:theta1_max;
theta2_range = theta2_min:resolution:theta2_max;
[theta1_grid, theta2_grid] = meshgrid(theta1_range, theta2_range);
c_space = ones(size(theta1_grid));

% Check each cell in the grid for collisions with obstacles
for i = 1:numel(theta1_grid)
    theta1 = theta1_grid(i);
    theta2 = theta2_grid(i);
    x = L1*cos(theta1) + L2*cos(theta1+theta2);
    y = L1*sin(theta1) + L2*sin(theta1+theta2);
    for j = 1:length(obstacles)
        obstacle = obstacles(j);
        if strcmp(obstacle.shape, 'square')
            if x > obstacle.position(1)-obstacle.size(1)/2 && ...
                    x < obstacle.position(1)+obstacle.size(1)/2 && ...
                    y > obstacle.position(2)-obstacle.size(2)/2 && ...
                    y < obstacle.position(2)+obstacle.size(2)/2
                c_space(i) = obstacle.color;
                break;
            end
        elseif strcmp(obstacle.shape, 'triangle')
            if inpolygon(x, y, obstacle.position(1)+[-obstacle.size(1)/2, obstacle.size(1)/2, 0], ...
                    obstacle.position(2)+[-obstacle.size(2)/2, -obstacle.size(2)/2, obstacle.size(2)/2])
                c_space(i) = obstacle.color;
                break;
            end
        elseif strcmp(obstacle.shape, 'circle')
            if norm([x, y] - obstacle.position) < obstacle.size
                c_space(i) = obstacle.color;
                break;
            end
        end
    end
end

% Plot the C-Space
figure;
imagesc(theta1_range, theta2_range, c_space);
xlabel('theta1');
ylabel('theta2');
title('C-Space');

% Plot the Cartesian space
figure;
hold on;
for i = 1:numel(theta1_grid)
    theta1 = theta1_grid(i);
    theta2 = theta2_grid(i);
    x = L1*cos(theta1) + L2*cos(theta1+theta2);
    y = L1*sin(theta1) + L2*sin(theta1+theta2);
end