clc;
clear;
close all;

% =========================================================
% PARAMETERS
% =========================================================

frequency = 40000;          % Ultrasonic Frequency (Hz)
amplitude = 1;

time_end = 0.003;           % Total Simulation Time
fs = 1000000;               % Sampling Frequency

t = linspace(0, time_end, fs*time_end);

% =========================================================
% ULTRASONIC WAVE
% =========================================================

wave = amplitude * sin(2*pi*frequency*t);

% =========================================================
% BUBBLE FORMATION MODEL
% =========================================================
% Stage 1 : Bubble Formation
% Stage 2 : Bubble Growth
% Stage 3 : Bubble Collapse

bubble_radius = zeros(size(t));

for i = 1:length(t)

    % -----------------------------------------------------
    % STAGE 1 : INITIAL BUBBLE FORMATION
    % -----------------------------------------------------

    if t(i) < 0.0008

        bubble_radius(i) = ...
            0.5 + 5000*t(i);

    % -----------------------------------------------------
    % STAGE 2 : BUBBLE GROWTH
    % -----------------------------------------------------

    elseif t(i) < 0.002

        bubble_radius(i) = ...
            4 + 3*sin(2*pi*2000*t(i));

    % -----------------------------------------------------
    % STAGE 3 : BUBBLE COLLAPSE
    % -----------------------------------------------------

    else

        bubble_radius(i) = ...
            0.5 + 0.3*sin(2*pi*5000*t(i));

    end

end

% =========================================================
% COLLAPSE DETECTION
% =========================================================

collapse_index = bubble_radius < 1;

% =========================================================
% HIGH ENERGY GENERATION
% =========================================================

energy = 1 ./ (bubble_radius.^2);

energy = energy / max(energy);

% =========================================================
% COMMAND WINDOW OUTPUT
% =========================================================

disp('===================================================');
disp(' ULTRASONIC CAVITATION PROCESS ANALYSIS ');
disp('===================================================');

fprintf('\n');

fprintf('Ultrasonic Frequency      : %.0f Hz\n', ...
        frequency);

fprintf('Simulation Time           : %.4f sec\n', ...
        time_end);

fprintf('Maximum Bubble Radius     : %.2f micrometer\n', ...
        max(bubble_radius));

fprintf('Minimum Bubble Radius     : %.2f micrometer\n', ...
        min(bubble_radius));

fprintf('Maximum Energy Generated  : %.2f\n', ...
        max(energy));

fprintf('Number of Collapse Events : %d\n', ...
        sum(collapse_index));

fprintf('\n');

disp('PROCESS STAGES:');
disp('1. Bubble Formation');
disp('2. Bubble Growth');
disp('3. Bubble Collapse');
disp('4. High Energy Generation');

fprintf('\n');

disp('===================================================');

% =========================================================
% FIGURE 1 : ULTRASONIC WAVE
% =========================================================

figure;

subplot(4,1,1);

plot(t*1000, wave, ...
     'b', ...
     'LineWidth',2);

xlabel('Time (ms)', ...
       'FontWeight','bold');

ylabel('Amplitude', ...
       'FontWeight','bold');

title('Ultrasonic Wave Signal', ...
      'FontWeight','bold');

grid on;

% =========================================================
% FIGURE 2 : BUBBLE FORMATION AND COLLAPSE
% =========================================================

subplot(4,1,2);

plot(t*1000, bubble_radius, ...
     'r', ...
     'LineWidth',2);

xlabel('Time (ms)', ...
       'FontWeight','bold');

ylabel('Bubble Radius (\mum)', ...
       'FontWeight','bold');

title('Bubble Formation, Growth and Collapse', ...
      'FontWeight','bold');

grid on;

hold on;

% =========================================================
% STAGE MARKING
% =========================================================

xline(0.8, '--k', ...
      'Formation End', ...
      'LineWidth',2);

xline(2.0, '--m', ...
      'Growth End', ...
      'LineWidth',2);

% =========================================================
% FIGURE 3 : HIGH ENERGY GENERATION
% =========================================================

subplot(4,1,3);

plot(t*1000, energy, ...
     'k', ...
     'LineWidth',2);

xlabel('Time (ms)', ...
       'FontWeight','bold');

ylabel('Normalized Energy', ...
       'FontWeight','bold');

title('High Energy Generation During Bubble Collapse', ...
      'FontWeight','bold');

grid on;

hold on;

[max_energy, idx] = max(energy);

plot(t(idx)*1000, ...
     max_energy, ...
     'ro', ...
     'MarkerSize',10, ...
     'LineWidth',2);

text(t(idx)*1000, ...
     max_energy, ...
     ' Peak Energy', ...
     'FontWeight','bold');

% =========================================================
% FIGURE 4 : BUBBLE FORMATION TIME PLOT
% =========================================================

subplot(4,1,4);

formation_phase = t <= 0.0008;

plot(t(formation_phase)*1000, ...
     bubble_radius(formation_phase), ...
     'g', ...
     'LineWidth',3);

xlabel('Time (ms)', ...
       'FontWeight','bold');

ylabel('Bubble Radius (\mum)', ...
       'FontWeight','bold');

title('Bubble Formation with Time', ...
      'FontWeight','bold');

grid on;

% =========================================================
% 3D VISUALIZATION
% =========================================================

figure;

plot3(t*1000, ...
      bubble_radius, ...
      energy, ...
      'LineWidth',2);

xlabel('Time (ms)', ...
       'FontWeight','bold');

ylabel('Bubble Radius (\mum)', ...
       'FontWeight','bold');

zlabel('Energy', ...
       'FontWeight','bold');

title('3D Ultrasonic Cavitation Dynamics', ...
      'FontWeight','bold');

grid on;

view(45,30);

% =========================================================
% BUBBLE ANIMATION
% =========================================================

figure;

for k = 1:300:length(t)

    clf;

    r = bubble_radius(k);

    theta = linspace(0,2*pi,300);

    x = r*cos(theta);
    y = r*sin(theta);

    fill(x, y, energy(k));

    colormap hot;
    colorbar;

    axis equal;
    axis([-10 10 -10 10]);

    title(['Bubble Radius = ', ...
           num2str(r,'%.2f'), ...
           ' \mum   |   Energy = ', ...
           num2str(energy(k),'%.2f')], ...
           'FontWeight','bold');

    drawnow;

end

% =========================================================
% FINAL MESSAGE
% =========================================================

disp('SIMULATION COMPLETED SUCCESSFULLY');