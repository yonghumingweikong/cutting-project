clc; clear all; close all;

[profiles_1,Ts] = load_fullcut_dataset('student01');
[profiles_2,~] = load_fullcut_dataset('student02');
[profiles_3,~] = load_fullcut_dataset('student03');
[profiles_4,~] = load_fullcut_dataset('student04');
[profiles_5,~] = load_fullcut_dataset('student05');
[profiles_6,~] = load_fullcut_dataset('student06');
[profiles_7,~] = load_fullcut_dataset('student07');
[profiles_8,~] = load_fullcut_dataset('student08');
[profiles_9,~] = load_fullcut_dataset('student09');
[profiles_10,~] = load_fullcut_dataset('student10');
[profiles_11,~] = load_fullcut_dataset('student11');
[profiles_12,~] = load_fullcut_dataset('student12');

profiles = zeros(144,180);
profiles(1:12,:) = profiles_1;
profiles(13:24,:) = profiles_2;
profiles(25:36,:) = profiles_3;
profiles(37:48,:) = profiles_4;
profiles(49:60,:) = profiles_5;
profiles(61:72,:) = profiles_6;
profiles(73:84,:) = profiles_7;
profiles(85:96,:) = profiles_8;
profiles(97:108,:) = profiles_9;
profiles(109:120,:) = profiles_10;
profiles(121:132,:) = profiles_11;
profiles(133:144,:) = profiles_12;

pulse_params = readtable('pulse_params.csv');
pulse_params = table2array(pulse_params);