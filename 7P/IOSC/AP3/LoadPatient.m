% patient=40;

if patient == 48
    age = 15;
    weight = 50;
    height = 160;
    gender = -1;
    imc = weight / (height /100)^2;

    delay = 80;
    k = 0.193;
    E50 = 311;
    gamma = 1.67;
    E0 = 91;
    

else
    
    Patient = readmatrix("patients.csv");
    
    age = Patient(patient,2);
    weight = Patient(patient,3);
    height = Patient(patient,4);
    gender = Patient(patient,5);
    
    imc = weight / (height /100)^2;
    
    delay=Patient(patient,11);
    k=Patient(patient,12);
    E50=Patient(patient,13);
    gamma=Patient(patient,14);
    E0=Patient(patient,9);

end
% Elti = tf(k, [1 k], 'inputDelay', delay/60);
% model = E0 - (E0 * Elti^gamma)/(E50^gamma + Elti^gamma)
