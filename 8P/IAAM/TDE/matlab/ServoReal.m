%{
	Class to set Simulink model parameters for real servo actuator.
	Functions:
		servoReal()
        randomiseServoParameters()
%}

classdef ServoReal < handle
    
    properties (SetAccess = private)
        % Servo actuator parameters
        K
        K_d
        dP
        S
        dP_ref
        
        % Aerodynamic force
        K_aero
        
        % Control surface sensor noise (degrees)
        sensor_mean
        sensor_variance
    end
    
    methods (Access = public)
        
        % Class constructor
        function self = ServoReal()
            % Initialise servo actuator parameters
            self.K_d             = 8.45;
            self.dP              = 29;
            self.S               = 5800;
            self.dP_ref          = 33.5;
            self.K               = 0.6;
            
            % Initialise aerodynamic forces
            self.K_aero          = 647.7;
            
            % Initialse control surface sensor noise
            self.sensor_mean     = 0;
            self.sensor_variance = 0.0005;
        end
        
        % Set the hydraulic differential pressure dP
        % dP must be between 16 and 30, inclusive.
        function setdP(self,dP)
            if dP >= 16 && dP <= 30,
                self.dP  = dP;
            else
                disp('Invalid setting: dP must be between 16 and 30');
            end
        end
        
        % Set the servo damping coefficient K_d
        % K_d must be between 6.8 and 10, inclusive.
        function setK_d(self,K_d)
            if K_d >= 6.8 && K_d <= 10,
                self.K_d  = K_d;
            else
                disp('Invalid setting: K_d must be between 6.8 and 10');
            end
        end
        
        % Randomises the real servo parameters K_d and dP
        % K_d is sampled from a uniform distribution [6.8,10]
        % dP is sampled from a uniform distribution [16,30]
        function randomiseServoParameters(self)
            self.K_d = rand(1) * (10 - 6.8) + 6.8;
            self.dP  = rand(1) * (30 - 16) + 16;
        end
        
    end
    
end