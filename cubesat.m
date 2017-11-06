classdef cubesat < satellite

    properties
        
        z % the length of the cubesat on the axis normal to the earth
        x % the other side length a
        y % the other side length b (a and b basically interchangeable)
        
    end
    
    methods
        
        function self = cubesat(mass, x, y, z, height)
            
            self = self@satellite(mass, height);
            self.x = x;
            self.y = y;
            self.z = z;
            
        end
        
        function y = illuminated_area(self, angle)
            
            % a1 is the top surface facing away from earth
            a1 = self.x*self.y; 
            na = [-1; 0];
            
            % a2 is one of the side surfaces
            a2 = self.x*self.z;
            nb = [0; 1];
            nc = [0; -1];
            
            % a3 is the other side surface, important if x!=y
            a3 = self.y*self.z;
            
            % rotation matrix
            A = [cos(angle) sin(angle); -sin(angle) cos(angle)];
            
            % weighted sum of surface areas based on what proportion of
            % each surface normal is antiparallel with the sunbeam [1; 0]
            y = max([1 0]*A*na,0)*a1 ...
              + max([1 0]*A*nb,0)*a2 ...
              + max([1 0]*A*nc,0)*a2;
        
        end
        
    end
    
end