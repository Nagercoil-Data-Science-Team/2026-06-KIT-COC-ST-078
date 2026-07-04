clc;
clear;
close all;

% =========================================================
% ULTRASONIC PARAMETERS
% =========================================================

frequency = 40000;      % Hz
time_end = 0.003;
fs = 1000000;

t = linspace(0,time_end,fs*time_end);

% =========================================================
% ULTRASONIC WAVE
% =========================================================

wave = sin(2*pi*frequency*t);

% =========================================================
% BUBBLE FORMATION
% =========================================================

bubble_radius = zeros(size(t));

for i = 1:length(t)

    % Formation Stage
    if t(i) < 0.0008

        bubble_radius(i) = 0.5 + 5000*t(i);

    % Growth Stage
    elseif t(i) < 0.002

        bubble_radius(i) = 4 + 3*sin(2*pi*2000*t(i));

    % Collapse Stage
    else

        bubble_radius(i) = 0.5 + 0.3*sin(2*pi*5000*t(i));

    end

end

% =========================================================
% ENERGY GENERATION
% =========================================================

energy = 1 ./ (bubble_radius.^2);

energy = energy / max(energy);

% =========================================================
% COLLAPSE EVENTS
% =========================================================

collapse_index = bubble_radius < 1;

collapse_events = sum(collapse_index);

% =========================================================
% NANOPARTICLE GENERATION
% =========================================================
% Assume stronger cavitation produces smaller particles

particle_size = 150 - 120*energy;

% Add random nanoparticle distribution

particle_size = particle_size + randn(size(particle_size))*3;

% Remove negative sizes

particle_size(particle_size < 5) = 5;

% =========================================================
% NANOPARTICLE PREPARATION METHODS
% =========================================================

% ---------------------------------------------------------
% 1. CENTRIFUGATION
% ---------------------------------------------------------
% Removes larger unwanted particles

centrifuge_threshold = 80;

centrifuged_particles = ...
    particle_size(particle_size <= centrifuge_threshold);

% ---------------------------------------------------------
% 2. WASHING
% ---------------------------------------------------------
% Remove impurities

washing_efficiency = 0.95;

washed_particles = ...
    centrifuged_particles * washing_efficiency;

% ---------------------------------------------------------
% 3. DRYING
% ---------------------------------------------------------
% Moisture removal improves crystal quality

drying_factor = 0.90;

dried_particles = ...
    washed_particles * drying_factor;

% ---------------------------------------------------------
% 4. STABILIZATION
% ---------------------------------------------------------
% Surfactant stabilization prevents agglomeration

stabilization_noise = randn(size(dried_particles))*1;

stabilized_particles = ...
    dried_particles + stabilization_noise;

% =========================================================
% FINAL NANOPARTICLE RESULTS
% =========================================================

final_avg_size = mean(stabilized_particles);

final_min_size = min(stabilized_particles);

final_max_size = max(stabilized_particles);

particle_count = length(stabilized_particles);

% =========================================================
% COMMAND WINDOW OUTPUT
% =========================================================

disp('===================================================');
disp(' ULTRASONIC CAVITATION & NANOPARTICLE ANALYSIS ');
disp('===================================================');

fprintf('\n');

fprintf('Ultrasonic Frequency          : %.0f Hz\n', ...
        frequency);

fprintf('Simulation Time               : %.4f sec\n', ...
        time_end);

fprintf('Maximum Bubble Radius         : %.2f micrometer\n', ...
        max(bubble_radius));

fprintf('Minimum Bubble Radius         : %.2f micrometer\n', ...
        min(bubble_radius));

fprintf('Maximum Energy Generated      : %.2f\n', ...
        max(energy));

fprintf('Bubble Collapse Events        : %d\n', ...
        collapse_events);

fprintf('\n');

disp('---------------------------------------------');
disp(' NANOPARTICLE PREPARATION METHODS ');
disp('---------------------------------------------');

disp('1. Centrifugation Completed');
disp('2. Washing Completed');
disp('3. Drying Completed');
disp('4. Stabilization Completed');

fprintf('\n');

disp('---------------------------------------------');
disp(' FINAL NANOPARTICLE RESULTS ');
disp('---------------------------------------------');

fprintf('Total Nanoparticles Obtained  : %d\n', ...
        particle_count);

fprintf('Average Particle Size         : %.2f nm\n', ...
        final_avg_size);

fprintf('Minimum Particle Size         : %.2f nm\n', ...
        final_min_size);

fprintf('Maximum Particle Size         : %.2f nm\n', ...
        final_max_size);

fprintf('\n');

if final_avg_size < 50

    disp('RESULT: Ultra-small nanoparticles synthesized.');

elseif final_avg_size < 100

    disp('RESULT: Stable nanoparticles synthesized.');

else

    disp('RESULT: Large nanoparticles observed.');

end

fprintf('\n');

disp('===================================================');
disp(' SIMULATION COMPLETED SUCCESSFULLY ');
disp('===================================================');

% =========================================================
% FIGURE 1 : ULTRASONIC WAVE
% =========================================================

figure;

subplot(3,2,1);

plot(t*1000,wave,...
    'b','LineWidth',2);

xlabel('Time (ms)');
ylabel('Amplitude');

title('Ultrasonic Wave');

grid on;

% =========================================================
% FIGURE 2 : BUBBLE DYNAMICS
% =========================================================

subplot(3,2,2);

plot(t*1000,bubble_radius,...
    'r','LineWidth',2);

xlabel('Time (ms)');
ylabel('Bubble Radius (\mum)');

title('Bubble Formation and Collapse');

grid on;

% =========================================================
% FIGURE 3 : HIGH ENERGY GENERATION
% =========================================================

subplot(3,2,3);

plot(t*1000,energy,...
    'k','LineWidth',2);

xlabel('Time (ms)');
ylabel('Normalized Energy');

title('High Energy Generation');

grid on;

% =========================================================
% FIGURE 4 : PARTICLE SIZE DISTRIBUTION
% =========================================================

subplot(3,2,4);

histogram(stabilized_particles,20);

xlabel('Particle Size (nm)');
ylabel('Frequency');

title('Nanoparticle Size Distribution');

grid on;

% =========================================================
% FIGURE 5 : ENERGY VS PARTICLE SIZE
% =========================================================

subplot(3,2,5);

scatter(energy(1:length(particle_size)),...
        particle_size,...
        10,...
        'filled');

xlabel('Cavitation Energy');

ylabel('Particle Size (nm)');

title('Energy vs Particle Size');

grid on;

% =========================================================
% FIGURE 6 : NANOPARTICLE PREPARATION STAGES
% =========================================================

subplot(3,2,6);

stages = [...
    mean(particle_size), ...
    mean(centrifuged_particles), ...
    mean(washed_particles), ...
    mean(dried_particles), ...
    mean(stabilized_particles)];

bar(stages);

set(gca,...
    'XTickLabel',...
    {'Initial','Centrifuge','Wash','Dry','Stable'});

ylabel('Average Particle Size (nm)');

title('Nanoparticle Preparation Stages');

grid on;

% =========================================================
% 3D NANOPARTICLE VISUALIZATION
% =========================================================

figure;

scatter3(...
    energy(1:length(stabilized_particles)), ...
    stabilized_particles, ...
    rand(size(stabilized_particles)), ...
    20,...
    stabilized_particles,...
    'filled');

xlabel('Energy');

ylabel('Particle Size (nm)');

zlabel('Particle Distribution');

title('3D Nanoparticle Visualization');

grid on;

view(45,30);

colorbar;

% =========================================================
% NANOPARTICLE ANIMATION
% =========================================================

figure;

for k = 1:50:length(stabilized_particles)

    clf;

    sz = stabilized_particles(k);

    theta = linspace(0,2*pi,200);

    r = sz/20;

    x = r*cos(theta);
    y = r*sin(theta);

    fill(x,y,'cyan');

    axis equal;
    axis([-10 10 -10 10]);

    title(['Nanoparticle Size = ',...
           num2str(sz,'%.2f'),...
           ' nm']);

    drawnow;

end