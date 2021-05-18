function [profiles, Ts] = load_fullcut_dataset(student)

    AllFiles=dir("./dataset/data_processed/full_cuts/"+string(student)+"*.mat");
    N = height(AllFiles);

    load(AllFiles(1).name,'actual','Ts')
    profiles = zeros(N,180);
    profiles(1,1:length(actual)) = actual / 15000;

    for n = 2:N
        load(AllFiles(n).name,'actual');
        profiles(n,1:length(actual)) = actual / 15000;
    end

clear actual;

end