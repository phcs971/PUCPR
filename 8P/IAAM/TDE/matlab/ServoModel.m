%{
	Class to set Simulink model parameters for analytically redundant
    servo actuator model.
	Functions:
		servoReal()
        randomiseServoParameters()
%}

classdef ServoModel < handle
    
    properties (SetAccess = private)
        K_d
        dP
        S
        dP_ref
        K
    end
    
    methods (Access = public)
        
        % Class constructor
        function self = ServoModel()
            
            % Initialise servo model with nominal actuator parameters
            self.K_d    = 8.45;
            self.dP     = 29;
            self.S      = 5800;
            self.dP_ref = 33.5;
            self.K      = 0.6;
        end
        
    end
    
end