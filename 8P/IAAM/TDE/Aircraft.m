classdef Aircraft < handle
    
    properties (SetAccess = private)
        % aircraft longitudinal dynamics
        A
        B
        C
        D

        % transfer functions
        num_retard
        den_retard
        num1_nz
        den1_nz
        num2_nz
        den2_nz
        num1_q
        den1_q
        num2_q
        den2_q       
        
        % control law parameters
        Kd          % load factor controller gain (load factor command)
        Ki          % load factor controller gain (integral)
        Knx 		% load factor controller gain (axial load factor)
        Knz 		% load factor controller gain (normal load factor)
        Kq          % load factor controller gain (pitch rate)
        Kteta       % load factor controller gain (pitch angle)
        Kfpa 		% flight path angle controller gain
        
        KdF         % load factor controller gain after reconfiguration (load factor command)
        KiF         % load factor controller gain after reconfiguration  (integral)
        KnzF 		% load factor controller gain after reconfiguration  (normal load factor)
        KqF         % load factor controller gain after reconfiguration  (pitch rate)
        
        % turbulence parameters
        altitude
        V_trim
        turbulence_select
        
        % equilibirum
        AoA_trim
        Theta_trim
        Nz_trim
        
        % control input
        input_select            % control input selection
        input_amplitude         % control input amplitude
        input_start_time        % control input start time
        input_stop_time         % control input stop time
        input_amplitude2        % control input amplitude 2
        input_start_time2       % control input start time 2
        input_stop_time2        % control input stop time 2
        input_sine_frequency    % control input sine frequency
        input_sine_phase        % control input sine phase
    end
    
    methods (Access = public)
        
        % Class constructor
        function self = Aircraft()
            aircraftParameters = load('aircraftParameters.mat');
            
            self.A = aircraftParameters.A;
            self.B = aircraftParameters.B;
            self.C = aircraftParameters.C;
            self.D = aircraftParameters.D;

            % transfer functions
            self.num_retard = aircraftParameters.num_retard;
            self.den_retard = aircraftParameters.den_retard;
            self.num1_nz    = aircraftParameters.num1_nz;
            self.den1_nz    = aircraftParameters.den1_nz;
            self.num2_nz    = aircraftParameters.num2_nz;
            self.den2_nz    = aircraftParameters.den2_nz;
            self.num1_q     = aircraftParameters.num1_q;
            self.den1_q     = aircraftParameters.den1_q;
            self.num2_q     = aircraftParameters.num2_q;
            self.den2_q     = aircraftParameters.den2_q;
            
            % control law parameters
            self.Kd         = aircraftParameters.Kd;
            self.Ki         = aircraftParameters.Ki;
            self.Knx        = aircraftParameters.Knx;
            self.Knz        = aircraftParameters.Knz;
            self.Kq         = aircraftParameters.Kq;
            self.Kteta      = aircraftParameters.Kteta;
            self.Kfpa       = aircraftParameters.Kfpa;
            self.KdF         = aircraftParameters.KdF;
            self.KiF         = aircraftParameters.KiF;
            self.KnzF        = aircraftParameters.KnzF;
            self.KqF         = aircraftParameters.KqF;
              
            % Set flight point for Mach 0.8 at 38000 feet
            self.altitude   = 38000; %feet
            self.V_trim     = 236;   % meters per second
            
            % Set equilibrium point
            self.AoA_trim   = 1.2;
            self.Theta_trim = 1.2;
            self.Nz_trim    = 0.995;
            
            % Set light turbulence level
            self.setLightTurbulence();
            
            % Set control input to flight path angle control
            self.input_select             = 0;
            
            % Initialise load factor input step parameters
            self.input_amplitude          = 1;
            self.input_start_time         = 10;
            self.input_stop_time          = 20;

            self.input_amplitude2         = 0;
            self.input_start_time2        = 60;
            self.input_stop_time2         = 60;

            % Initialise load factor input sine parameters
            self.input_sine_frequency = 2*pi*1;
            %mod(self.input_start_time,2*pi/self.input_sine_frequency)
            self.input_sine_phase = mod(self.input_start_time,2*pi/self.input_sine_frequency)*self.input_sine_frequency;
            
            % Initialise load factor input chirp parameters
            % input_amplitude already initialised
            
        end

        % Disable turbulence
        function setNoTurbulence(self)
            self.turbulence_select = 0;
        end
        
        % Set light turbulence level
        function setLightTurbulence(self)
            self.turbulence_select = 1;
        end

        % Set moderate turbulence level
        function setModerateTurbulence(self)
            self.turbulence_select = 2;
        end
        
        % Set severe turbulence level
        function setSevereTurbulence(self)
            self.turbulence_select = 3;
        end
        
        % Get turbulence level
        function turbulence = getTurbulence(self)
            switch self.turbulence_select
                case 0
                    turbulence = 'None';
                case 1
                    turbulence = 'Light';
                case 2
                    turbulence = 'Moderate';
                case 3
                    turbulence = 'Severe';
                otherwise
                    turbulence = 'Undefined';
            end
        end

        % Set control input
        function setControlInput(self,input_type,input_amplitude,input_start_time,input_stop_time,input_sine_frequency_hz)
            if nargin > 3
                if input_start_time < 0
                    input_start_time = 0;
                end
                if input_stop_time < input_start_time
                    input_stop_time = input_start_time;
                end 
            end
            switch upper(input_type)
                case 'FPA_CONTROL'
                    self.input_select = 0;
                case 'NZ_STEP'
                    self.input_select     = 1;
                    self.input_amplitude  = input_amplitude;
                    self.input_start_time = input_start_time;
                    self.input_stop_time  = input_stop_time;
                case 'NZ_SINE'
                    self.input_select = 2;                   
                    self.input_amplitude  = input_amplitude;
                    self.input_start_time = input_start_time;
                    self.input_stop_time  = input_stop_time;
                    self.input_sine_frequency = 2*pi*input_sine_frequency_hz;
                    self.input_sine_phase = mod(self.input_start_time,2*pi/self.input_sine_frequency)*self.input_sine_frequency;
                case 'NZ_CHIRP'
                    self.input_select = 3;
                    self.input_amplitude  = input_amplitude;
                    self.input_start_time = 0;
                    self.input_stop_time  = 999999;
                otherwise
                    % do nothing
            end
        end

        % Set control input 2
        function setControlInput2(self,input_amplitude2,input_start_time2,input_stop_time2)
            if self.input_select == 1
                if input_start_time2 < self.input_start_time
                    input_start_time2 = self.input_start_time;
                end
                if input_stop_time2 < input_start_time2
                    input_stop_time2 = input_start_time2;
                end 
                self.input_amplitude2  = input_amplitude2;
                self.input_start_time2 = input_start_time2;
                self.input_stop_time2  = input_stop_time2;
            end
        end
    end   
end