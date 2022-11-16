classdef Simulation < handle
    
    properties (SetAccess = private)
        simulink_model  % Simulink model
        Fs              % sampling frequency (Hz)
        stopTime        % simulation stop time (seconds)
        ofcDetectedTime % time to force ofc_detected flag high (seconds)
    end

    methods (Access = public)
        
        % Class constructor
        function self = Simulation()
            self.simulink_model = 'ofc_benchmark';
            self.Fs              = 40;
            self.stopTime        = 60;
            self.ofcDetectedTime = 40;
            open_system(self.simulink_model);
        end
        
        % Set simulink model to be used for simulation
        function setSimulinkModel(self,simulink_model)
            close_system(self.simulink_model);
            self.simulink_model = simulink_model;
            open_system(self.simulink_model);
        end
        
        function [simulink_model] = getSimulinkModel(self)
            simulink_model= self.simulink_model;
        end

        function setOFCDetectedTime(self,ofcDetectedTime)
            self.ofcDetectedTime = ofcDetectedTime;
        end

    end
    
end