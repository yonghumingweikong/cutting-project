% close all; clc;

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

% pulse_params_px = pulse_params;
% for i=1:height(pulse_params_px)
%     indx = zeros(1,10);
%     indx(1) = pulse_params(i,1);
%     for j = 2:10
%         indx(j) = indx(j-1) + pulse_params(i,j);
%     end
%     pulse_params_px(i,1:10) = indx;
% end

% data = pulse_params(:,11:20);
data_norm = normalize(pulse_params);
[coeff,score,latent,tsquared,explained] = pca(data_norm);

% for i = 1:5
%     figure; hold on; 
%     scatter(data_norm(1:12,i),data_norm(1:12,10+i),'+'); % student 1
%     scatter(data_norm(13:24,i),data_norm(13:24,10+i),'o'); % student 2
%     scatter(data_norm(25:36,i),data_norm(25:36,10+i),'*'); % student 3
%     scatter(data_norm(37:48,i),data_norm(37:48,10+i),'x'); % student 4
%     scatter(data_norm(49:60,i),data_norm(49:60,10+i),'s','filled'); % student 5
%     scatter(data_norm(61:72,i),data_norm(61:72,10+i),'d'); % student 6
%     scatter(data_norm(73:84,i),data_norm(73:84,10+i),'^'); % student 7
%     scatter(data_norm(85:96,i),data_norm(85:96,10+i),'v'); % student 8
%     scatter(data_norm(97:108,i),data_norm(97:108,10+i),'>'); % student 9
%     scatter(data_norm(109:120,i),data_norm(109:120,10+i),'<'); % student 10
%     scatter(data_norm(121:132,i),data_norm(121:132,10+i),'p','filled'); % student 11
%     scatter(data_norm(133:144,i),data_norm(133:144,10+i),'h'); % student 12
% end

% poi = 27;
% 
figure; hold on; 
scatter(score(1:12,1),score(1:12,2),'+'); % student 1
scatter(score(13:24,1),score(13:24,2),'o'); % student 2
scatter(score(25:36,1),score(25:36,2),'*'); % student 3
scatter(score(37:48,1),score(37:48,2),'x'); % student 4
scatter(score(49:60,1),score(49:60,2),'s'); % student 5
scatter(score(61:72,1),score(61:72,2),'d'); % student 6
scatter(score(73:84,1),score(73:84,2),'^'); % student 7
scatter(score(85:96,1),score(85:96,2),'v'); % student 8
scatter(score(97:108,1),score(97:108,2),'>'); % student 9
scatter(score(109:120,1),score(109:120,2),'<'); % student 10
scatter(score(121:132,1),score(121:132,2),'p'); % student 11
scatter(score(133:144,1),score(133:144,2),'h'); % student 12
title('PCA'); grid on;

% cluster = find(score(:,1) < -2);
% figure; hold on; 
% for i = 1:length(cluster)
%     Pulse = pulse3(pulse_params(cluster(i),:),180);
%     plot(Pulse); 
% end
% figure; hold on; 
% for i = 1:length(cluster)
%     plot(profiles(cluster(i),:));
% end

plot_pulse_fit(pulse_params(60,:),profiles(60,:),Ts)


% figure; hold on; 
% cluster = [125,127,128,130,131,132,58,60];
% for i = 1:length(cluster)
%     p = pulse(pulse_params(cluster(i),:));
%     plot(p);
% end

% 
% figure; hold on; 
% cluster = [41,42,45,46,47];
% for i = 1:length(cluster)
%     plot_pulse(pulse_params(cluster(i),:),profiles(cluster(i),:),Ts)
% end
% 
% figure; plot_pulse(pulse_params(27,:),profiles(27,:),Ts)


% figure; 
% scatter3(score(1:12,1),score(1:12,2),score(1:12,3),'+'); hold on; % student 1
% scatter3(score(13:24,1),score(13:24,2),score(13:24,3),'o'); % student 2
% scatter3(score(25:36,1),score(25:36,2),score(25:36,3),'*'); % student 3
% scatter3(score(37:48,1),score(37:48,2),score(37:48,3),'x'); % student 4
% scatter3(score(49:60,1),score(49:60,2),score(49:60,3),'s','filled'); % student 5
% scatter3(score(61:72,1),score(61:72,2),score(61:72,3),'d'); % student 6
% scatter3(score(73:84,1),score(73:84,2),score(73:84,3),'^'); % student 7
% scatter3(score(85:96,1),score(85:96,2),score(85:96,3),'v'); % student 8
% scatter3(score(97:108,1),score(97:108,2),score(97:108,3),'>'); % student 9
% scatter3(score(109:120,1),score(109:120,2),score(109:120,3),'<'); % student 10
% scatter3(score(121:132,1),score(121:132,2),score(121:132,3),'p','filled'); % student 11
% scatter3(score(133:144,1),score(133:144,2),score(133:144,3),'h'); % student 12