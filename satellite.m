classdef satellite

    properties (Constant)
        
        M = 5.972*10^24;    % mass of the earth in kg
        G = 6.67408*10^-20; % gravitational constant in km^3/(kg*s^2)
        r_earth = 6371;     % approximate radius of the earth in km
    
    end
    
    properties
        
        m   % mass of the cubesat in kg
        h   % height of orbit in km
        
    end

    methods

        function self = satellite(mass, height)
            % constructor
            self.m = mass;
            self.h = height;
        end

        function y = v(self)
            % calculate orbital velocity in km/s
            y = sqrt(self.G*self.M*self.m/(self.r_earth + self.h));
        end

        function y = angular_v(self)
            % calculate angular velocity in radians/s
            y = self.v/(self.r_earth + self.h);
        end
        
        function y = orbit_time(self)
            % calculate the period (time per one orbit) in seconds
            y = 2*pi/self.angular_v;
        end
        
        function y = eclipse_time(self)
            % calculat the time the satellite spends completely in shadow
            y = 2*asin(self.r_earth/(self.r_earth + self.h))/self.angular_v;
        end
        
    end
    
end