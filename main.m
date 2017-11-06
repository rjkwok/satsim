
% define our satellite as 1 kg and 0.1m*0.1m*0.2m at a 2000km height
sfusat = cubesat(1, 0.1, 0.1, 0.2, 2000);

% only one state variable, initially 0 halfway through eclipse region
angle = 0;

% dt and max_time in seconds
dt = 60;
max_time = 24*60*60;

% arrays to save data for plotting
x = [];
y = [];

for t = 0:dt:max_time
    
    x = [x; t];
    y = [y; sfusat.illuminated_area(angle)];
    
    angle = mod(angle + sfusat.angular_v*dt, 2*pi);
    
end

plot(x, y);
