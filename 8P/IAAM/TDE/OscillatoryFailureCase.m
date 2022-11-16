%{
	Class to inject OFC into Simulink model.
	Functions:
		oscillatoryFailureCase()
		disableOFC()
		enableRandomOFC()
		getLocation()
		setLocation()
		getType()
		setType()
		getAmplitude()
		setAmplitude()
		getStartTime()
		setStartTime()
		isSolid()
		isLiquid()
		isCurrent()
		isRodSensor()
		isControlSurface()
		isCSSensor()
		getBias()
		setBias()
		getFrequency()
		setFrequency()
		getPhase()
		setPhase()
%}


classdef OscillatoryFailureCase < handle

	properties (SetAccess = private)
		amplitude 				% Amplitude of the OFC (unit [mm or mA] is dependent on location)
		frequency 				% Frequency of the OFC [rad/s]
		bias 					% DC offset of the OFC
		start_time 				% Simulation time [seconds] when OFC should start
		enable_rod_sensor_ofc 	% Enables the failure at the rod position sensor
		enable_current_ofc 		% Enables the failure at the current command
		enable_cs_ofc 			% Enables the OFC at the control surface (represent a physical disconnection of the control surface from the rod)
		enable_cs_sensor_ofc 	% Enables the failure at the control surface sensor (i.e. the one used only for monitoring)
		liquid_ofc 				% The failure is liquid
		solid_ofc 				% The failure is solid
        phase 					% Initial phase of the OFC (referenced to t = 0 seconds)

	end

	methods (Access = public)

		% Class constructor
		function self = OscillatoryFailureCase()
			self.disableOFC();
		end

		% Disables all OFCs
		function disableOFC(self)
			self.amplitude = 0;
			self.frequency = 0;
			self.bias = 0;
			self.start_time = 0;
			self.enable_rod_sensor_ofc = 0;
			self.enable_current_ofc = 0;
			self.enable_cs_ofc = 0;
			self.enable_cs_sensor_ofc = 0;
			self.liquid_ofc = 0;
			self.solid_ofc = 0;
            self.phase = 0;
		end

		% Enables a random OFC at a random location and time
		function enableRandomOFC(self, sim_time)

			start_time_min = 5; 									% Earliest time an ofc can be enabled

			loc = rand(1); 											% Random location
			self.enable_rod_sensor_ofc = (loc < 0.25);
			self.enable_current_ofc = (loc >= 0.25 && loc < 0.5);
			self.enable_cs_ofc = (loc >= 0.5 && loc < 0.75);
			self.enable_cs_sensor_ofc = (loc > 0.75);

			typ = rand(1); 											% Random type
			self.liquid_ofc = (typ < 1 / 3);
			self.solid_ofc = (typ >= 1 / 3 && typ < 2 / 3);

			self.amplitude = rand(1) * 15;
			self.frequency = (rand(1) * 9) + 1;
			self.frequency = self.frequency * 2 * pi;
			self.bias = (rand(1) * 15) * double(self.solid_ofc);
			self.start_time = rand(1) * (sim_time - (2 * start_time_min)) + start_time_min;

			if (typ >= 2 / 3)
				self.disableOFC();
			end

		end

		% Get current location of OFC
		function location = getLocation(self)
			if (self.enable_rod_sensor_ofc)
				location = 'sensor';
			elseif (self.enable_current_ofc)
				location = 'current';
			elseif (self.enable_cs_ofc)
				location = 'cs'
			elseif (self.enable_cs_sensor_ofc)
				location = 'cs_sensor';
			else
				location = 'none';
			end
		end

		%{
		Set location of OFC
		Parameters:
			(string) location: Can be set to:
									'sensor': Rod position sensor in actuator,
									'current': Velocity or current command delivered to actuator,
									'cs': Control Surface,
									'cs_sensor': Control surface sensor used for fault detection
		%}
		function setLocation(self, location)

			self.enable_cs_sensor_ofc = 0;
			self.enable_cs_ofc = 0;
			self.enable_rod_sensor_ofc = 0;
			self.enable_current_ofc = 0;

			if strcmp(location, 'sensor')
				self.enable_rod_sensor_ofc = 1;
			elseif strcmp(location, 'current')
				self.enable_current_ofc = 1;
			elseif strcmp(location, 'cs')
				self.enable_cs_ofc = 1;
			elseif strcmp(location, 'cs_sensor')
				self.enable_cs_sensor_ofc = 1;
			end
		end

		% Returns type of OFC: 'liquid', 'solid', or 'none'
		function ofc_type = getType(self)
			if (self.liquid_ofc)
				ofc_type = 'liquid';
			elseif (self.solid_ofc)
				ofc_type = 'solid';
			else
				ofc_type = 'none';
			end
		end

		%{
		Sets type of OFC
		Parameters:
			(string) ofc_type: Can be set to 'liquid' or 'solid'
		%}
		function setType(self, ofc_type)

			if strcmp(ofc_type, 'liquid')
				self.liquid_ofc = 1;
				self.solid_ofc = 0;
				self.bias = 0;
			elseif strcmp(ofc_type, 'solid')
				self.liquid_ofc = 0;
				self.solid_ofc = 1;
			end
		end

		% Get amplitude of OFC
		function [ofc_amplitude] = getAmplitude(self)
			ofc_amplitude = self.amplitude;
		end

		% Set amplitude of OFC. Units will vary based on location (mm for rod sensor, mA for current command)
		function setAmplitude(self, amplitude)
			self.amplitude = amplitude;
		end

		% Get start time of OFC
		function [ofc_start_time] = getStartTime(self)
			ofc_start_time = self.start_time;
		end

		% Set start time of OFC, in seconds
		function setStartTime(self, start_time)
			self.start_time = start_time;
		end

		% Returns true if OFC is a solid failure (used in Simulink model)
		function [solid] = isSolid(self)
			solid = self.solid_ofc;
		end

		% Returns true if OFC is a liquid failure (used in Simulink model)
		function [liquid] = isLiquid(self)
			liquid = self.liquid_ofc;
		end

		% Returns true if OFC is present at current command (used in Simulink model)
		function [current] = isCurrent(self)
			current = self.enable_current_ofc;
		end

		% Returns true if OFC is present at rod sensor (used in Simulink model)
		function [rod_sensor] = isRodSensor(self)
			rod_sensor = self.enable_rod_sensor_ofc;
		end

		% Returns true if OFC is present at control surface (used in Simulink model)
		function [cs] = isControlSurface(self)
			cs = self.enable_cs_ofc;
		end

		% Returns true if OFC is present at control surface sensor (used in Simulink model)
		function [cs_sensor] = isCSSensor(self)
			cs_sensor = self.enable_cs_sensor_ofc;
		end

		% Returns DC offset of failure
		function [ofc_bias] = getBias(self)
			ofc_bias = self.bias;
		end

		% Set DC offset of OFC (recommended to leave 0)
		function setBias(self, bias)
			self.bias = bias;
		end

		% Returns frequency (rad/s) of OFC
		function [ofc_freq] = getFrequency(self)
			ofc_freq = self.frequency;
		end

		% Set frequency (rad/s) of OFC
		function setFrequency(self, frequency)
			self.frequency = frequency;
        end
        
        % Set initial phase (rad) of OFC
        function setPhase(self, phase)
            self.phase = phase;
        end
        
        % Returns initial phase (rad) of OFC
        function [phase] = getPhase(self)
            phase = self.phase;
        end


	end



end