
% define our satellite as 1 kg and 0.1m*0.1m*0.2m at a 2000km height
sfusat = cubesat(1, 0.1, 0.1, 0.2, 2000);

% set the spin rate of the satellite in rad/s
sfusat.spin = 0;

% only one state variable, initially 0 halfway through eclipse region
angle = 0;
spin_angle = 0;

% dt and max_time in seconds
dt = 60;
max_time = 24*60*60;

% arrays to save data for plotting
x = [];
y = [];

for t = 0:dt:max_time
    
    x = [x; (t/60)/60];
    y = [y; sfusat.illuminated_area(angle, spin_angle)*100*100];
    
    angle = mod(angle + sfusat.angular_v*dt, 2*pi);
    spin_angle = mod(spin_angle + sfusat.spin*dt, 2*pi);
    
end

plot(x, y);
xlabel('time (hours)')
ylabel('effective area (cm^2)')