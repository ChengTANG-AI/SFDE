%Start
clc
clear
tic

time=1;                         % Runing times
F_index=1;                      % Problem number
divide_rate=0.75;                 % Train and test data rate
popSize=10;                      % Population size
Max_Gen=10;                    % Maximum iteration

kz = [  5,  5, 10,  5,  5,  5,  5,  5,  2,  2];
mz = [  3,  3,  3,  4,  3,  4,  4,  4,  3,  3];
qz = [0.4,0.4,0.8,0.4,0.4,0.4,0.4,0.4,0.4,0.4];

kcz = kz(F_index);
mcz = mz(F_index);
qcz = qz(F_index);

for t=1:time
    flag = 1;
    disp(['**  F_index = ' num2str(F_index) '  **  Time = ' num2str(t)]);
    
    [Mse, rMse, Mape, Mae, R, Convergence, target_data, output_data, Mset, rMset, Mapet, Maet, Rt] = SFDE_func(F_index, divide_rate, Max_Gen, popSize,kcz,mcz,qcz);
    ALNM_Mse_test(flag,t) = Mse;
    ALNM_rMse_test(flag,t) = rMse;
    ALNM_Mape_test(flag,t) = Mape;
    ALNM_Mae_test(flag,t) = Mae;
    ALNM_R_test(flag,t) = R;
    ALNM_Mse_train(flag,t) = Mset;
    ALNM_rMse_train(flag,t) = rMset;
    ALNM_Mape_train(flag,t) = Mapet;
    ALNM_Mae_train(flag,t) = Maet;
    ALNM_R_train(flag,t) = Rt;
    ALNM_SFDE_Convergence(t,:) = Convergence;
    ALNM_SFDE_target_data(t,:) = target_data;
    ALNM_SFDE_output_data(t,:) = output_data;
    disp('SFDE Over');
    
end
toc;

save ALNM_Mse_test ALNM_Mse_test
save ALNM_rMse_test ALNM_rMse_test
save ALNM_Mape_test ALNM_Mape_test
save ALNM_Mae_test ALNM_Mae_test
save ALNM_R_test ALNM_R_test

save ALNM_Mse_train ALNM_Mse_train
save ALNM_rMse_train ALNM_rMse_train
save ALNM_Mape_train ALNM_Mape_train
save ALNM_Mae_train ALNM_Mae_train
save ALNM_R_train ALNM_R_train

save ALNM_SFDE_Convergence ALNM_SFDE_Convergence
save ALNM_SFDE_target_data ALNM_SFDE_target_data
save ALNM_SFDE_output_data ALNM_SFDE_output_data

disp('Over');