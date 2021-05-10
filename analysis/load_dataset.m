function [reference, profiles, Ts] = load_dataset(student)

    AllFiles=dir("data/30Hz/"+string(student)+"/*.mat");
    N = height(AllFiles);

    load(AllFiles(1).name,'reference','actual','Ts')
    reference = reference / 15000;
    profiles = zeros(N,length(reference));
    profiles(1,1:length(actual)) = actual / 15000;

    for n = 2:N
        load(AllFiles(n).name,'actual');
        profiles(n,1:length(actual)) = actual / 15000;
    end

clear actual;

end