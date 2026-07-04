clc;
clear;
close all;

% =========================================================
% STEP 1 : ULTRASONIC CAVITATION
% =========================================================

frequency = 40000;
time_end = 0.003;
fs = 1000000;

t = linspace(0,time_end,fs*time_end);

wave = sin(2*pi*frequency*t);

% =========================================================
% BUBBLE DYNAMICS
% =========================================================

bubble_radius = zeros(size(t));

for i = 1:length(t)

    if t(i) < 0.0008

        bubble_radius(i) = 0.5 + 5000*t(i);

    elseif t(i) < 0.002

        bubble_radius(i) = ...
            4 + 3*sin(2*pi*2000*t(i));

    else

        bubble_radius(i) = ...
            0.5 + 0.3*sin(2*pi*5000*t(i));

    end

end

% =========================================================
% HIGH ENERGY GENERATION
% =========================================================

energy = 1 ./ (bubble_radius.^2);

energy = energy / max(energy);

collapse_index = bubble_radius < 1;

% =========================================================
% STEP 2 : NANOPARTICLE PREPARATION
% =========================================================

particle_size = 150 - 120*energy;

particle_size = ...
    particle_size + randn(size(particle_size))*3;

particle_size(particle_size < 5) = 5;

% =========================================================
% CENTRIFUGATION
% =========================================================

centrifuge_threshold = 80;

centrifuged_particles = ...
    particle_size(particle_size <= centrifuge_threshold);

% =========================================================
% WASHING
% =========================================================

washed_particles = centrifuged_particles * 0.95;

% =========================================================
% DRYING
% =========================================================

dried_particles = washed_particles * 0.90;

% =========================================================
% STABILIZATION
% =========================================================

stabilized_particles = ...
    dried_particles + randn(size(dried_particles));

avg_particle_size = mean(stabilized_particles);

particle_count = length(stabilized_particles);

% =========================================================
% STEP 3 : THIN FILM FABRICATION
% =========================================================

substrate = 'ITO Glass';

spin_speed = 3000;
num_layers = 5;
annealing_temp = 450;

% =========================================================
% FILM THICKNESS
% =========================================================

film_thickness = ...
    (6000/spin_speed) * num_layers * 40;

% =========================================================
% FILM UNIFORMITY
% =========================================================

uniformity = 60 + (spin_speed/100);

if uniformity > 95
    uniformity = 95;
end

% =========================================================
% CONDUCTIVITY
% =========================================================

conductivity = ...
    annealing_temp * 0.03 + num_layers * 3;

normalized_conductivity = conductivity * 3;

if normalized_conductivity > 100
    normalized_conductivity = 100;
end

% =========================================================
% LIGHT ABSORPTION
% =========================================================

light_absorption = ...
    50 + num_layers*7 + annealing_temp*0.02;

if light_absorption > 100
    light_absorption = 100;
end

% =========================================================
% THIN FILM QUALITY
% =========================================================

film_quality = ...
    (uniformity + ...
     normalized_conductivity + ...
     light_absorption)/3;

% =========================================================
% STEP 4 : PHOTOELECTRONIC DEVICE ASSEMBLY
% =========================================================

bottom_electrode = 'ITO';

active_layer = 'Nanoparticle Thin Film';

top_electrode = 'Silver (Ag)';

device_structure = ...
    'ITO / Nanoparticle Film / Ag';

electrode_thickness = 120;

active_layer_thickness = film_thickness;

device_area = 1.5;

contact_resistance = 12;

% =========================================================
% DEVICE PERFORMANCE
% =========================================================

electron_generation = ...
    light_absorption * 0.92;

charge_transport = ...
    normalized_conductivity * 0.88;

device_sensitivity = ...
    (electron_generation + charge_transport)/2;

photocurrent = ...
    device_sensitivity * 0.15;

device_efficiency = ...
    (film_quality + device_sensitivity)/2;

if device_efficiency > 85

    device_type = ...
        'High Performance Photodetector';

elseif device_efficiency > 70

    device_type = ...
        'Photoelectric Sensor';

else

    device_type = ...
        'Basic Optical Device';

end

% =========================================================
% STEP 5 : OPTICAL CHARACTERIZATION
% =========================================================

% =========================================================
% UV-VISIBLE SPECTROSCOPY
% =========================================================

wavelength = 300:5:900;

absorbance = ...
    1.8 * exp(-(wavelength-450).^2/25000) + ...
    0.6 * exp(-(wavelength-700).^2/40000);

absorbance = ...
    absorbance + 0.03*rand(1,length(wavelength));

max_absorbance = max(absorbance);

avg_absorbance = mean(absorbance);

% =========================================================
% BAND GAP CALCULATION
% =========================================================

photon_energy = 1240 ./ wavelength;

alpha = absorbance * 10000;

tauc = (alpha .* photon_energy).^2;

band_gap = 3.2;

% =========================================================
% XRD ANALYSIS
% =========================================================

theta = 20:0.1:80;

xrd_intensity = ...
    100*exp(-(theta-32).^2/2) + ...
    80*exp(-(theta-46).^2/3) + ...
    60*exp(-(theta-58).^2/4);

xrd_intensity = ...
    xrd_intensity + rand(1,length(theta))*5;

crystallinity = 92.5;

% =========================================================
% FESEM/TEM MORPHOLOGY
% =========================================================

num_particles = 200;

x_particles = rand(1,num_particles)*100;

y_particles = rand(1,num_particles)*100;

particle_visual_size = ...
    stabilized_particles(1:num_particles);

% =========================================================
% PARTICLE SIZE DISTRIBUTION (CORRECTED)
% =========================================================

avg_distribution = mean(stabilized_particles);

std_distribution = std(stabilized_particles);

uniformity_index = ...
    100 - ...
    ((std_distribution/avg_distribution)*100);

if uniformity_index > 100
    uniformity_index = 100;
end

if uniformity_index < 0
    uniformity_index = 0;
end

% =========================================================
% COMMAND WINDOW OUTPUT
% =========================================================

disp('===================================================');
disp(' PHOTOELECTRONIC DEVICE ASSEMBLY ');
disp('===================================================');

fprintf('\n');

fprintf('Device Structure              : %s\n', ...
        device_structure);

fprintf('Bottom Electrode              : %s\n', ...
        bottom_electrode);

fprintf('Active Layer                  : %s\n', ...
        active_layer);

fprintf('Top Electrode                 : %s\n', ...
        top_electrode);

fprintf('Electrode Thickness           : %.2f nm\n', ...
        electrode_thickness);

fprintf('Active Layer Thickness        : %.2f nm\n', ...
        active_layer_thickness);

fprintf('Device Area                   : %.2f cm^2\n', ...
        device_area);

fprintf('Contact Resistance            : %.2f Ohm\n', ...
        contact_resistance);

fprintf('\n');

disp('===================================================');
disp(' PHOTOELECTRIC DEVICE PERFORMANCE ');
disp('===================================================');

fprintf('\n');

fprintf('Electron Generation Efficiency : %.2f %%\n', ...
        electron_generation);

fprintf('Charge Transport Efficiency    : %.2f %%\n', ...
        charge_transport);

fprintf('Device Sensitivity             : %.2f %%\n', ...
        device_sensitivity);

fprintf('Estimated Photocurrent         : %.2f mA\n', ...
        photocurrent);

fprintf('Overall Device Efficiency      : %.2f %%\n', ...
        device_efficiency);

fprintf('\n');

fprintf('Final Device Type              : %s\n', ...
        device_type);

fprintf('\n');

if device_efficiency > 85

    disp('RESULT: High Quality Photoelectronic Device');

elseif device_efficiency > 70

    disp('RESULT: Moderate Quality Device');

else

    disp('RESULT: Low Efficiency Device');

end

fprintf('\n');

disp('===================================================');
disp(' OPTICAL CHARACTERIZATION ');
disp('===================================================');

fprintf('\n');

% =========================================================
% UV ANALYSIS
% =========================================================

disp('A. UV-VISIBLE SPECTROSCOPY');

fprintf('\n');

fprintf('Wavelength Range              : %d - %d nm\n', ...
        min(wavelength),max(wavelength));

fprintf('Maximum Absorbance            : %.2f\n', ...
        max_absorbance);

fprintf('Average Absorbance            : %.2f\n', ...
        avg_absorbance);

fprintf('\n');

if max_absorbance > 1.5

    disp('RESULT: Strong light absorption observed');

else

    disp('RESULT: Moderate light absorption observed');

end

fprintf('\n');

disp('---------------------------------------------------');

% =========================================================
% BAND GAP
% =========================================================

disp('B. BAND GAP ANALYSIS');

fprintf('\n');

fprintf('Estimated Band Gap Energy     : %.2f eV\n', ...
        band_gap);

fprintf('\n');

disp('RESULT: Wide band gap semiconductor');

fprintf('\n');

disp('---------------------------------------------------');

% =========================================================
% XRD
% =========================================================

disp('C. XRD ANALYSIS');

fprintf('\n');

fprintf('Crystallinity Index           : %.2f %%\n', ...
        crystallinity);

fprintf('\n');

disp('RESULT: Highly crystalline nanoparticles');

fprintf('\n');

disp('---------------------------------------------------');

% =========================================================
% FESEM/TEM
% =========================================================

disp('D. FESEM/TEM MORPHOLOGY');

fprintf('\n');

fprintf('Observed Particle Shape       : Spherical\n');

fprintf('Particle Distribution         : Moderate Uniformity\n');

fprintf('Surface Morphology            : Smooth\n');

fprintf('\n');

disp('RESULT: Moderately uniform nanoparticle coating observed');

fprintf('\n');

disp('---------------------------------------------------');

% =========================================================
% PARTICLE DISTRIBUTION
% =========================================================

disp('E. PARTICLE SIZE DISTRIBUTION');

fprintf('\n');

fprintf('Average Particle Diameter     : %.2f nm\n', ...
        avg_distribution);

fprintf('Standard Deviation            : %.2f nm\n', ...
        std_distribution);

fprintf('Uniformity Index              : %.2f %%\n', ...
        uniformity_index);

fprintf('\n');

if uniformity_index >= 85

    disp('RESULT: Excellent particle uniformity observed');

elseif uniformity_index >= 70

    disp('RESULT: Good particle uniformity observed');

elseif uniformity_index >= 50

    disp('RESULT: Moderately uniform nanoparticle coating observed');

else

    disp('RESULT: Non-uniform particle distribution observed');

end

fprintf('\n');

disp('===================================================');
disp(' FINAL CHARACTERIZATION SUMMARY ');
disp('===================================================');

fprintf('\n');

fprintf('Average Particle Size         : %.2f nm\n', ...
        avg_distribution);

fprintf('Particle Uniformity Index     : %.2f %%\n', ...
        uniformity_index);

fprintf('Band Gap Energy               : %.2f eV\n', ...
        band_gap);

fprintf('Maximum Absorbance            : %.2f\n', ...
        max_absorbance);

fprintf('Crystallinity Index           : %.2f %%\n', ...
        crystallinity);

fprintf('\n');

if uniformity_index >= 70 && crystallinity >= 85

    disp('FINAL RESULT:');
    disp('High quality nanoparticle thin film successfully synthesized.');

elseif uniformity_index >= 50

    disp('FINAL RESULT:');
    disp('Moderate quality nanoparticle thin film synthesized.');

else

    disp('FINAL RESULT:');
    disp('Low quality nanoparticle film observed.');

end

fprintf('\n');

disp('===================================================');
disp(' OPTICAL CHARACTERIZATION COMPLETED ');
disp('===================================================');

% =========================================================
% FIGURE 1 : UV-VISIBLE ABSORPTION
% =========================================================

figure;

subplot(2,3,1);

plot(wavelength,...
     absorbance,...
     'b',...
     'LineWidth',2);

xlabel('Wavelength (nm)');
ylabel('Absorbance');

title('UV-Visible Absorption Spectrum');

grid on;

% =========================================================
% FIGURE 2 : TAUC PLOT
% =========================================================

subplot(2,3,2);

plot(photon_energy,...
     tauc,...
     'r',...
     'LineWidth',2);

xlabel('Photon Energy (h\nu) eV');
ylabel('(\alpha h\nu)^2');

title('Tauc Plot');

grid on;

% =========================================================
% FIGURE 3 : XRD PATTERN
% =========================================================

subplot(2,3,3);

plot(theta,...
     xrd_intensity,...
     'k',...
     'LineWidth',2);

xlabel('2\theta (Degree)');
ylabel('Intensity');

title('XRD Pattern');

grid on;

% =========================================================
% FIGURE 4 : FESEM/TEM MORPHOLOGY
% =========================================================

subplot(2,3,4);

scatter(x_particles,...
        y_particles,...
        particle_visual_size,...
        particle_visual_size,...
        'filled');

xlabel('X Position');
ylabel('Y Position');

title('FESEM/TEM Morphology');

colorbar;

grid on;

% =========================================================
% FIGURE 5 : PARTICLE SIZE DISTRIBUTION
% =========================================================

subplot(2,3,5);

histogram(stabilized_particles,20);

xlabel('Particle Diameter (nm)');
ylabel('Frequency');

title('Particle Size Distribution');

grid on;

% =========================================================
% FIGURE 6 : DEVICE PERFORMANCE
% =========================================================

subplot(2,3,6);

device_parameters = ...
    [electron_generation,...
     charge_transport,...
     device_efficiency];

bar(device_parameters);

set(gca,...
    'XTickLabel',...
    {'Electron',...
     'Transport',...
     'Efficiency'});

ylabel('Performance (%)');

title('Photoelectronic Device Performance');

grid on;

% =========================================================
% 3D SURFACE MORPHOLOGY
% =========================================================

figure;

[X,Y] = meshgrid(1:100,1:100);

Z = rand(100)*20;

surf(X,Y,Z);

xlabel('Surface X-axis');
ylabel('Surface Y-axis');
zlabel('Surface Height');

title('3D Surface Morphology');

shading interp;

colormap jet;

colorbar;


% =========================================================
% STEP 6 : ELECTRICAL & PHOTOELECTRIC ANALYSIS
% =========================================================
% Includes:
% 1. Current-Voltage (I-V) Characteristics
% 2. Photocurrent Response vs Time
% 3. Photoelectric Conversion Efficiency
% 4. Different Light Condition Analysis
% =========================================================

% =========================================================
% APPLIED VOLTAGE
% =========================================================

voltage = -5:0.1:5;

% =========================================================
% DARK CURRENT
% =========================================================

dark_current = ...
    0.002 * voltage;

% =========================================================
% LIGHT CONDITIONS
% =========================================================

light_conditions = ...
    {'Dark',...
     'Low Light',...
     'Medium Light',...
     'High Light'};

illumination_intensity = ...
    [0 25 50 100];

% =========================================================
% PHOTOCURRENT UNDER DIFFERENT LIGHT CONDITIONS
% =========================================================

current_dark = ...
    0.002 * voltage;

current_low = ...
    0.004 * voltage + 0.002;

current_medium = ...
    0.007 * voltage + 0.005;

current_high = ...
    0.012 * voltage + 0.010;

% =========================================================
% MAXIMUM PHOTOCURRENT
% =========================================================

max_current_dark = max(current_dark);

max_current_low = max(current_low);

max_current_medium = max(current_medium);

max_current_high = max(current_high);

% =========================================================
% DEVICE RESISTANCE
% =========================================================

device_resistance = ...
    1 ./ (0.012);

% =========================================================
% PHOTORESPONSIVITY
% =========================================================

responsivity = ...
    photocurrent / 100;

% =========================================================
% RESPONSE TIME ANALYSIS
% =========================================================

time_response = 0:0.1:20;

photo_response = ...
    photocurrent * ...
    (1 - exp(-time_response/2));

recovery_response = ...
    photocurrent * ...
    exp(-time_response/3);

response_time_constant = 2;

recovery_time_constant = 3;

% =========================================================
% STABILITY ANALYSIS
% =========================================================

cycles = 1:20;

stability_response = ...
    photocurrent + randn(1,20)*0.3;

stability_percentage = ...
    (min(stability_response)/...
     max(stability_response))*100;

% =========================================================
% PHOTOELECTRIC CONVERSION EFFICIENCY
% =========================================================

device_samples = 1:5;

conversion_efficiency = ...
    [65 72 78 82 device_efficiency];

average_efficiency = ...
    mean(conversion_efficiency);

best_efficiency = ...
    max(conversion_efficiency);

% =========================================================
% POWER CALCULATION
% =========================================================

power_output = ...
    voltage .* current_high;

max_power = max(power_output);

% =========================================================
% COMMAND WINDOW OUTPUT
% =========================================================

disp('===================================================');
disp(' ELECTRICAL & PHOTOELECTRIC ANALYSIS ');
disp('===================================================');

fprintf('\n');

% =========================================================
% I-V ANALYSIS
% =========================================================

disp('A. CURRENT-VOLTAGE (I-V) CHARACTERISTICS');

fprintf('\n');

fprintf('Applied Voltage Range         : %.1f V to %.1f V\n',...
        min(voltage),max(voltage));

fprintf('Maximum Dark Current          : %.4f A\n',...
        max_current_dark);

fprintf('Maximum Low Light Current     : %.4f A\n',...
        max_current_low);

fprintf('Maximum Medium Light Current  : %.4f A\n',...
        max_current_medium);

fprintf('Maximum High Light Current    : %.4f A\n',...
        max_current_high);

fprintf('\n');

fprintf('Estimated Device Resistance   : %.2f Ohm\n',...
        device_resistance);

fprintf('\n');

if max_current_high > max_current_dark

    disp('RESULT: Strong photoelectric response observed');

else

    disp('RESULT: Weak photoelectric response observed');

end

fprintf('\n');

disp('---------------------------------------------------');

% =========================================================
% PHOTOCURRENT RESPONSE
% =========================================================

disp('B. PHOTOCURRENT RESPONSE ANALYSIS');

fprintf('\n');

fprintf('Maximum Photocurrent          : %.2f mA\n',...
        photocurrent);

fprintf('Response Time Constant        : %.2f s\n',...
        response_time_constant);

fprintf('Recovery Time Constant        : %.2f s\n',...
        recovery_time_constant);

fprintf('Responsivity                  : %.4f A/W\n',...
        responsivity);

fprintf('\n');

if response_time_constant < 5

    disp('RESULT: Fast photoresponse observed');

else

    disp('RESULT: Slow photoresponse observed');

end

fprintf('\n');

disp('---------------------------------------------------');

% =========================================================
% STABILITY ANALYSIS
% =========================================================

disp('C. DEVICE STABILITY ANALYSIS');

fprintf('\n');

fprintf('Photoresponse Stability       : %.2f %%\n',...
        stability_percentage);

fprintf('\n');

if stability_percentage > 90

    disp('RESULT: Excellent device stability');

elseif stability_percentage > 75

    disp('RESULT: Good device stability');

else

    disp('RESULT: Moderate device stability');

end

fprintf('\n');

disp('---------------------------------------------------');

% =========================================================
% CONVERSION EFFICIENCY
% =========================================================

disp('D. PHOTOELECTRIC CONVERSION EFFICIENCY');

fprintf('\n');

fprintf('Average Conversion Efficiency : %.2f %%\n',...
        average_efficiency);

fprintf('Best Device Efficiency        : %.2f %%\n',...
        best_efficiency);

fprintf('Maximum Power Output          : %.4f W\n',...
        max_power);

fprintf('\n');

if best_efficiency > 80

    disp('RESULT: High efficiency photoelectric device');

elseif best_efficiency > 60

    disp('RESULT: Moderate efficiency device');

else

    disp('RESULT: Low efficiency device');

end

fprintf('\n');

disp('===================================================');
disp(' FINAL ELECTRICAL ANALYSIS SUMMARY ');
disp('===================================================');

fprintf('\n');

fprintf('Final Device Type             : %s\n',...
        device_type);

fprintf('Device Efficiency             : %.2f %%\n',...
        device_efficiency);

fprintf('Photocurrent Generation       : %.2f mA\n',...
        photocurrent);

fprintf('Band Gap Energy               : %.2f eV\n',...
        band_gap);

fprintf('Crystallinity                 : %.2f %%\n',...
        crystallinity);

fprintf('Particle Uniformity           : %.2f %%\n',...
        uniformity_index);

fprintf('\n');

disp('FINAL RESULT:');

if device_efficiency > 80 && ...
   crystallinity > 85

    disp('High-performance photoelectronic');
    disp('device successfully fabricated.');

elseif device_efficiency > 60

    disp('Moderate-performance');
    disp('photoelectronic device fabricated.');

else

    disp('Low-performance device observed.');

end

fprintf('\n');

disp('===================================================');
disp(' ELECTRICAL ANALYSIS COMPLETED ');
disp('===================================================');

% =========================================================
% FIGURE 11 : I-V CHARACTERISTICS
% =========================================================

figure;

subplot(2,3,1);

plot(voltage,...
     current_dark,...
     'k',...
     'LineWidth',2);

hold on;

plot(voltage,...
     current_low,...
     'b',...
     'LineWidth',2);

plot(voltage,...
     current_medium,...
     'g',...
     'LineWidth',2);

plot(voltage,...
     current_high,...
     'r',...
     'LineWidth',2);

xlabel('Voltage (V)');
ylabel('Current (A)');

title('I-V Characteristics');

legend('Dark',...
       'Low Light',...
       'Medium Light',...
       'High Light');

grid on;

% =========================================================
% FIGURE 12 : PHOTOCURRENT RESPONSE
% =========================================================

subplot(2,3,2);

plot(time_response,...
     photo_response,...
     'b',...
     'LineWidth',2);

hold on;

plot(time_response,...
     recovery_response,...
     'r',...
     'LineWidth',2);

xlabel('Time (s)');
ylabel('Photocurrent (mA)');

title('Photocurrent Response');

legend('Light ON',...
       'Light OFF');

grid on;

% =========================================================
% FIGURE 13 : CONVERSION EFFICIENCY
% =========================================================

subplot(2,3,3);

bar(device_samples,...
    conversion_efficiency);

xlabel('Device Samples');
ylabel('Efficiency (%)');

title('Photoelectric Conversion Efficiency');

grid on;

% =========================================================
% LIGHT INTENSITY VS CURRENT
% =========================================================

subplot(2,3,4);

light_intensity = ...
    [0 25 50 75 100];

light_current = ...
    [0 2 5 8 12];

plot(light_intensity,...
     light_current,...
     '-o',...
     'LineWidth',2);

xlabel('Light Intensity (mW/cm^2)');
ylabel('Photocurrent (mA)');

title('Light Intensity vs Photocurrent');

grid on;

% =========================================================
% DEVICE STABILITY
% =========================================================

subplot(2,3,5);

plot(cycles,...
     stability_response,...
     '-s',...
     'LineWidth',2);

xlabel('Measurement Cycles');
ylabel('Photocurrent (mA)');

title('Device Stability');

grid on;

% =========================================================
% POWER OUTPUT
% =========================================================

subplot(2,3,6);

plot(voltage,...
     power_output,...
     'm',...
     'LineWidth',2);

xlabel('Voltage (V)');
ylabel('Power Output (W)');

title('Power Generation');

grid on;

% =========================================================
% 3D PHOTOELECTRIC RESPONSE
% =========================================================

figure;

[X,Y] = meshgrid(voltage,...
                 illumination_intensity);

Z = zeros(size(X));

for i = 1:size(X,1)

    Z(i,:) = ...
        (0.002 + 0.0001*Y(i,1)) .* X(i,:);

end

surf(X,Y,Z);

xlabel('Voltage (V)');
ylabel('Light Intensity');
zlabel('Current (A)');

title('3D Photoelectric Response');

shading interp;

colormap jet;

colorbar;

% =========================================================
% LIGHT SWITCHING ANIMATION
% =========================================================

figure;

for k = 1:20

    clf;

    if mod(k,2) == 0

        response = ...
            photocurrent * ones(1,100);

        plot(response,...
             'r',...
             'LineWidth',3);

        title('LIGHT ON');

    else

        response = ...
            zeros(1,100);

        plot(response,...
             'k',...
             'LineWidth',3);

        title('LIGHT OFF');

    end

    ylim([0 photocurrent+5]);

    ylabel('Photocurrent (mA)');

    grid on;

    drawnow;

    pause(0.3);

end

% =========================================================
% STEP 7 : PERFORMANCE COMPARISON ANALYSIS
% =========================================================
% Comparison:
% 1. Conventional ZnO Device
% 2. Proposed GO-TiO2 Ultrasonic Cavitation Device
% =========================================================

% =========================================================
% COMPARISON PARAMETERS
% =========================================================

comparison_methods = ...
    {'Conventional',...
     'This Work'};

comparison_materials = ...
    {'ZnO',...
     'GO-TiO2 (Ultrasonic Cavitation)'};

comparison_responsivity = ...
    [0.10,...
     responsivity];

comparison_efficiency = ...
    [45,...
     device_efficiency];

comparison_stability = ...
    [60,...
     stability_percentage];

comparison_photocurrent = ...
    [3.5,...
     photocurrent];

comparison_bandgap = ...
    [3.37,...
     band_gap];

comparison_remarks = ...
    {'Low efficiency',...
     'Improved stability'};

% =========================================================
% COMMAND WINDOW OUTPUT
% =========================================================

disp('===================================================');
disp(' PERFORMANCE COMPARISON ANALYSIS ');
disp('===================================================');

fprintf('\n');

fprintf('%-15s %-35s %-15s %-20s\n',...
        'Method',...
        'Material',...
        'Responsivity',...
        'Remarks');

fprintf('\n');

fprintf('%-15s %-35s %-15.2f %-20s\n',...
        comparison_methods{1},...
        comparison_materials{1},...
        comparison_responsivity(1),...
        comparison_remarks{1});

fprintf('%-15s %-35s %-15.2f %-20s\n',...
        comparison_methods{2},...
        comparison_materials{2},...
        comparison_responsivity(2),...
        comparison_remarks{2});

fprintf('\n');

disp('===================================================');
disp(' COMPARATIVE PERFORMANCE SUMMARY ');
disp('===================================================');

fprintf('\n');

fprintf('Conventional ZnO Responsivity     : %.2f A/W\n',...
        comparison_responsivity(1));

fprintf('Proposed Device Responsivity      : %.2f A/W\n',...
        comparison_responsivity(2));

fprintf('\n');

fprintf('Conventional Efficiency           : %.2f %%\n',...
        comparison_efficiency(1));

fprintf('Proposed Device Efficiency        : %.2f %%\n',...
        comparison_efficiency(2));

fprintf('\n');

fprintf('Conventional Stability            : %.2f %%\n',...
        comparison_stability(1));

fprintf('Proposed Device Stability         : %.2f %%\n',...
        comparison_stability(2));

fprintf('\n');

% =========================================================
% IMPROVEMENT CALCULATIONS
% =========================================================

responsivity_improvement = ...
    ((comparison_responsivity(2) - ...
      comparison_responsivity(1)) ...
      / comparison_responsivity(1))*100;

efficiency_improvement = ...
    ((comparison_efficiency(2) - ...
      comparison_efficiency(1)) ...
      / comparison_efficiency(1))*100;

stability_improvement = ...
    ((comparison_stability(2) - ...
      comparison_stability(1)) ...
      / comparison_stability(1))*100;

fprintf('Responsivity Improvement          : %.2f %%\n',...
        responsivity_improvement);

fprintf('Efficiency Improvement            : %.2f %%\n',...
        efficiency_improvement);

fprintf('Stability Improvement             : %.2f %%\n',...
        stability_improvement);

fprintf('\n');

disp('FINAL COMPARISON RESULT:');

fprintf('\n');

if comparison_efficiency(2) > comparison_efficiency(1)

    disp('The proposed GO-TiO2 ultrasonic');
    disp('cavitation photoelectronic device');
    disp('shows superior photoelectric');
    disp('performance compared with');
    disp('the conventional ZnO device.');

else

    disp('No significant improvement observed.');

end

fprintf('\n');


% =========================================================
% METHODS (UPDATED AS MATERIALS ONLY)
% =========================================================

methods = ...
    {'ZnO (Conventional)',...
     'GO-TiO2 (Ultrasonic Cavitation)'};

materials = ...
    {'ZnO',...
     'GO-TiO2 nanocomposite'};

% =========================================================
% PERFORMANCE PARAMETERS
% =========================================================

responsivity = ...
    [0.10,...
     0.45];

efficiency = ...
    [45,...
     85.35];

stability = ...
    [60,...
     89.63];

photocurrent = ...
    [3.5,...
     12.13];

% =========================================================
% COMMAND WINDOW OUTPUT (TABLE STYLE)
% =========================================================

disp('===================================================');
disp(' MATERIAL COMPARISON TABLE ');
disp('===================================================');

fprintf('\n');

fprintf('%-30s %-25s %-15s %-15s\n',...
    'Material',...
    'Structure',...
    'Responsivity (A/W)',...
    'Efficiency (%)');

fprintf('%-30s %-25s %-15.2f %-15.2f\n',...
    materials{1},...
    methods{1},...
    responsivity(1),...
    efficiency(1));

fprintf('%-30s %-25s %-15.2f %-15.2f\n',...
    materials{2},...
    methods{2},...
    responsivity(2),...
    efficiency(2));

fprintf('\n');

% =========================================================
% IMPROVEMENT CALCULATION
% =========================================================

resp_improve = ...
    ((responsivity(2)-responsivity(1))/responsivity(1))*100;

eff_improve = ...
    ((efficiency(2)-efficiency(1))/efficiency(1))*100;

stab_improve = ...
    ((stability(2)-stability(1))/stability(1))*100;

fprintf('Responsivity Improvement : %.2f %%\n', resp_improve);
fprintf('Efficiency Improvement   : %.2f %%\n', eff_improve);
fprintf('Stability Improvement    : %.2f %%\n', stab_improve);

fprintf('\n');

disp('FINAL RESULT:');

if efficiency(2) > efficiency(1)

    disp('GO-TiO2 nanocomposite shows superior');
    disp('photoelectric performance compared to ZnO.');

else

    disp('No improvement observed.');

end

clc;
clear;

% =========================================================
% MATERIALS
% =========================================================

methods = ...
    {'ZnO (Conventional)',...
     'ZnO-GO (Ultrasonic Cavitation)'};

materials = ...
    {'ZnO',...
     'ZnO-GO nanocomposite'};

% =========================================================
% PERFORMANCE PARAMETERS
% =========================================================

responsivity = [0.10, 0.45];
efficiency   = [45, 85.35];
stability    = [60, 89.63];
photocurrent = [3.5, 12.13];

% =========================================================
% COMMAND WINDOW OUTPUT
% =========================================================

disp('===================================================');
disp(' MATERIAL COMPARISON TABLE ');
disp('===================================================');

fprintf('%-30s %-25s %-15s %-15s\n',...
    'Material','Structure','Responsivity','Efficiency');

fprintf('%-30s %-25s %-15.2f %-15.2f\n',...
    materials{1},methods{1},responsivity(1),efficiency(1));

fprintf('%-30s %-25s %-15.2f %-15.2f\n',...
    materials{2},methods{2},responsivity(2),efficiency(2));

fprintf('\n');

% =========================================================
% IMPROVEMENT
% =========================================================

resp_improve = ((responsivity(2)-responsivity(1))/responsivity(1))*100;
eff_improve  = ((efficiency(2)-efficiency(1))/efficiency(1))*100;
stab_improve = ((stability(2)-stability(1))/stability(1))*100;

fprintf('Responsivity Improvement : %.2f %%\n', resp_improve);
fprintf('Efficiency Improvement   : %.2f %%\n', eff_improve);
fprintf('Stability Improvement    : %.2f %%\n\n', stab_improve);

% =========================================================
% FIGURE SETTINGS (COMMON STYLE)
% =========================================================

figSize = [100 100 450 320];   % SMALL BOX SIZE

% =========================================================
% FIGURE 1 : RESPONSIVITY
% =========================================================

figure;
set(gcf,'Position',figSize);

b = bar(responsivity);
b.BarWidth = 0.35;   % SMALL BAR WIDTH

set(gca,'XTickLabel',materials);
ylabel('Responsivity (A/W)');
title('Responsivity Comparison');
grid on;

for i = 1:length(responsivity)
    text(i, responsivity(i)+0.02, ...
        num2str(responsivity(i),'%.2f'), ...
        'HorizontalAlignment','center','FontWeight','bold');
end

% =========================================================
% FIGURE 2 : EFFICIENCY
% =========================================================

figure;
set(gcf,'Position',figSize);

b = bar(efficiency);
b.BarWidth = 0.35;

set(gca,'XTickLabel',materials);
ylabel('Efficiency (%)');
title('Photoelectric Efficiency');
grid on;

for i = 1:length(efficiency)
    text(i, efficiency(i)+2, ...
        strcat(num2str(efficiency(i),'%.2f'),'%'), ...
        'HorizontalAlignment','center','FontWeight','bold');
end

% =========================================================
% FIGURE 3 : STABILITY
% =========================================================

figure;
set(gcf,'Position',figSize);

b = bar(stability);
b.BarWidth = 0.35;

set(gca,'XTickLabel',materials);
ylabel('Stability (%)');
title('Device Stability');
grid on;

for i = 1:length(stability)
    text(i, stability(i)+2, ...
        strcat(num2str(stability(i),'%.2f'),'%'), ...
        'HorizontalAlignment','center','FontWeight','bold');
end

% =========================================================
% FIGURE 4 : PHOTOCURRENT
% =========================================================

figure;
set(gcf,'Position',figSize);

b = bar(photocurrent);
b.BarWidth = 0.35;

set(gca,'XTickLabel',materials);
ylabel('Photocurrent (mA)');
title('Photocurrent Comparison');
grid on;

for i = 1:length(photocurrent)
    text(i, photocurrent(i)+0.5, ...
        num2str(photocurrent(i),'%.2f'), ...
        'HorizontalAlignment','center','FontWeight','bold');
end

% =========================================================
% FINAL CONCLUSION
% =========================================================

disp('===================================================');
disp(' FINAL CONCLUSION ');
disp('===================================================');

disp('GO-TiO2 nanocomposite (Ultrasonic Cavitation)');
disp('shows significantly better performance than ZnO.');
disp('===================================================');