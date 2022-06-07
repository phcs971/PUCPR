% patient=40;

Patient = readmatrix("patients.csv");

delay=Patient(patient,11);
k=Patient(patient,12);
E50=Patient(patient,13);
gamma=Patient(patient,14);
E0=Patient(patient,9);

% Elti = tf(k, [1 k], 'inputDelay', delay/60);
% model = E0 - (E0 * Elti^gamma)/(E50^gamma + Elti^gamma)
