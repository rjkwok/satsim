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

        function obj = satellite(mass, height)
            % constructor
            obj.m = mass;
            obj.h = height;
        end

        function y = v(obj)
            % calculate orbital velocity in km/s
            y = sqrt(obj.G*obj.M*obj.m/(obj.r_earth + obj.h));
        end

        function y = angular_v(obj)
            % calculate angular velocity in radians/s
            y = obj.v()/(obj.r_earth + obj.h);
        end
        
        function y = T(obj)
            % calculate the period (time per one orbit) in seconds
            y = 2*pi/obj.angular_v();
        end
        
    end
    
end