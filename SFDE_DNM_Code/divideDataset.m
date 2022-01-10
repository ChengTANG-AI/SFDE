% Start
function [ trainx, trainy, testx, testy, denNumber ] = divideDataset( F_index, divide_rate, mcz)

switch  F_index
    case 1
        load ISE_TL_P1.mat
    case 2
        load ISE_USD_P1.mat
    case 3
        load SP_P1.mat
    case 4
        load DAX_P1.mat
    case 5
        load FTSE_P1.mat
    case 6
        load NIKKEI_P1.mat
    case 7
        load EU_P1.mat
    case 8
        load EM_P1.mat
    case 9
        load DJIA_P1.mat
    case 10
        load NIFTY_P1.mat
    otherwise
        disp(['-----------Please assign the Benchmark Data!-----------']);
end

[m,n] = size(data);
denNumber = m + mcz - 1;

midpoint = round(divide_rate*n);

trainx = data(1:(m - 1), 1:midpoint);
testx = data(1:(m - 1), (midpoint + 1):n);
trainy = data(m, 1:midpoint);
testy = data(m, (midpoint + 1):n);

end

