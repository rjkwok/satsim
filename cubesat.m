classdef cubesat < satellite

    properties
        
        z % the length of the cubesat on the axis normal to the earth
        x % the other side length a
        y % the other side length b (a and b basically interchangeable)
        
        spin % rads/s, because the cubesat can spin about the z axis freely
    end
    
    methods
        
        function self = cubesat(mass, x, y, z, height)
            
            self = self@satellite(mass, height);
            self.x = x;
            self.y = y;
            self.z = z;
            self.spin = 0;
            
        end
        
        function y = illuminated_area(self, angle, spin_angle)
            
            eclipse_max = self.eclipse_angle;
            eclipse_min = 2*pi - self.eclipse_angle;
            
            % if satellite is in the eclipse region, illumination is 0
            if (angle < eclipse_max | angle > eclipse_min)
                y = 0;
                return
            end
            
            % a1 is the top surface facing away from earth
            a1 = self.x*self.y; 
            na = [-1; 0; 0];
            
            % a2 is one of the side surfaces
            a2 = self.x*self.z;
            nb = [0; 1; 0];
            nc = [0; -1; 0];
            
            % a3 is the other side surface, important if x!=y
            a3 = self.y*self.z;
            nd = [0; 0; 1];
            ne = [0; 0; -1];
            
            % spin rotation about axis normal to earth
            spin_matrix = rotation(spin_angle, 1, 0, 0);
            
            nb = spin_matrix*nb;
            nc = spin_matrix*nc;
            nd = spin_matrix*nd;
            ne = spin_matrix*ne;
            
            % major rotation about earth
            orbit_matrix = rotation(angle, 0, 0, 1);
            
            % weighted sum of surface areas based on what proportion of
            % each normal is antiparallel with the sunbeam [1; 0, 0]
            y = max([1 0 0]*orbit_matrix*na,0)*a1 ...
              + max([1 0 0]*orbit_matrix*nb,0)*a2 ...
              + max([1 0 0]*orbit_matrix*nc,0)*a2 ...
              + max([1 0 0]*orbit_matrix*nd,0)*a3 ...
              + max([1 0 0]*orbit_matrix*ne,0)*a3;

        end
        
    end
    
end