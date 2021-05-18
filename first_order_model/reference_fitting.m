clf; close all; clc;

figure;
plot(reference); hold on;
plot(1:10:length(reference),reference(1:10:length(reference)),'o');

x = cat(2,1:10,11:10:length(reference)-1);
x([3,4,5,12,13]) = [];
y = reference(x);

figure; plot(x,y,'-o'); hold on; plot(reference,'--');

p = polyfit(x,y,5);

plot(x,polyval(p,x));

reference_c = polyval(p,1:length(reference));
reference_c = reference_c - reference_c(1);

figure; plot(1:length(reference),reference_c); % bias to origin
hold on; plot(reference,'--');

