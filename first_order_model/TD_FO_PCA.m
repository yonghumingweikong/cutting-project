close all; clc;

data = [1.983688619	3.284815258	1.142720377	0.5274865334;
3.590041774	3.147717683	3.720717976	0.2918099744;
1.981854799	1.575778997	0.8776148072	0.4391810623;
2.348108324	5.160986403	1.111890872	0.5473910969;
1.731324196	3.433766208	0.08468603277	0.6850758821;
1.226372405	2.376695372	0.7560960251	0.9562525759;
2.098422622	2.983093254	1.354860529	0.3516130829;
2.295279468	3.087942122	0.4782171109	0.204273188;
1.777699129	-0.4366915565	2.744344877	1.22548822;
2.780430086	3.435597052	2.404293641	0.1318666585;
2.66309037	3.283907359	1.249542965	0.1502609195;
2.188103586	3.521303072	0.3643334632	0.209902723;
1.596867476	1.922295583	-0.2284107934	0.5373708052;
0.8121038384	0.9967516102	0.9623388794	1.195198717;
1.126951528	1.069135534	-0.08681593021	1.253672489;
1.520952764	1.578815351	-0.1795182495	0.4803583915;
0.6261412493	1.122115478	-0.4618880509	0.6080949382;
1.453361726	1.40015467	-0.2492758941	0.5725751924;
1.66886139	2.187255319	-0.196561381	0.2436049097;
0.9689085601	1.454465625	0.3821268892	1.083944283;
1.119088059	1.766631908	0.7487024052	0.9378102197;
2.199011881	2.273626965	2.09740376	0.1552280157;
1.75588022	2.495061434	0.3942511701	0.122696337;
1.976183965	3.77966389	-0.05008504349	0.2446981409;
1.848453921	2.1123615	-0.7553969488	0.2740444341;
1.261997327	1.561140195	1.483408341	1.093034678;
1.039536278	1.790452302	-1.335305909	0.4744329454;
1.511738012	0.4797950149	0.300363708	0.4398995806;
1.093820319	0.7403342248	-0.6954317698	0.5444809804;
2.363420994	2.507058797	2.315825926	1.160103873;
2.144502297	3.166504157	0.3258558124	0.1499943006;
1.307070936	1.469394277	-0.1519377743	0.8502137312;
1.806664884	0.6644699261	0.6178371646	0.2784112128;
2.020957914	1.65787694	-0.1625871489	0.409616804;
0.8697029239	0.5244306655	-0.7344769401	0.5492756429;
1.265386878	0.6493247133	-0.6497011494	0.6231383675;
1.220014317	1.647320321	-0.518641952	0.5477758898;
1.394918201	0.8942880267	0.8179905859	0.6250859085;
1.421802282	0.680963471	0.4917687817	0.5251957134;
2.435938192	3.277411937	0.1449836179	0.4382574756;
1.40003786	0.3931939704	0.1218963268	0.4973703679;
1.390643821	1.048363873	-0.4471325428	0.4806808715;
1.243502506	0.9833730725	0.9662986663	0.7822996027;
1.298865004	1.257585338	-0.1422274816	0.3908128636;
3.083894556	2.782076232	2.365437774	0.4498417354;
1.617437351	2.456128682	0.1990435285	0.3801374217;
1.572549255	0.4828376484	0.2113652829	0.4396223513;
1.284104806	0.5502735711	0.1712996925	0.7076714375;
1.776791281	0.6217458964	0.5708793823	0.2302019806;
2.662632203	3.627903134	0.8410018393	0.2034199667;
1.45802612	0.5042845101	-0.1846273525	0.5433954008;
1.47462719	0.6426857304	0.1246157607	0.4911354945
1.738292783	2.777788395	0.8724129282	0.6468111554;
1.395279507	1.748259646	-0.4066138908	0.3515520512;
1.182476089	1.585056362	-0.1723633183	0.5389356784;
1.169430728	2.010850494	-0.07264437639	0.4562582363;
1.995434638	1.077849876	1.355798097	0.01131704517;
1.426281152	1.941043403	-0.2287293832	0.3940763342;
1.867409624	2.962768482	-0.2730644085	0.3920318971;
1.620328269	2.362708806	0.643167331	0.619180158;
1.090614426	1.585319572	0.07071748579	0.4671971676;
1.157336022	1.003871645	0.98820166	0.8889257627;
1.633283988	2.003636808	-0.3312074167	0.3684140401;
1.39413848	2.098089778	0.02260104275	0.3941756805;
1.090075285	1.99519447	-0.06104041099	0.4699265822;
1.868612596	3.549859739	0.7188103435	0.835352893;
1.22253522	1.109500289	-0.5282992926	0.5023284121;
2.058068551	3.408243503	2.002729509	0.1862690523;
3.089529741	2.291850524	3.452721528	0.155259261;
2.676560389	2.452491954	2.332217248	0.06887401642;
1.294072293	0.9261135513	1.133057507	0.6373089926;
1.554780066	1.634108415	-0.07878557222	0.3032335242;
3.110149254	3.07817149	3.129234662	0.1031709176;
1.722102659	0.9377264026	1.424170488	0.1980911184;
1.877566145	1.130292892	1.530025055	0.09652585755;
1.687709424	1.823027194	-0.322540263	0.2494347366
];

profiles = zeros(height(profiles_1)+height(profiles_2)+height(profiles_5)+height(profiles_4),length(profiles_1));
profiles(1:20,:) = profiles_1;
profiles(21:52,:) = profiles_2;
profiles(53:64,:) = profiles_5;
profiles(65:end,:) = profiles_4;

[coeff,score,latent,tsquared,explained] = pca(data);

poi = 55;

figure;
scatter(score(1:20,1),score(1:20,2),'o'); hold on;
scatter(score(21:52,1),score(21:52,2),'v');
scatter(score(53:64,1),score(53:64,2),'x');
scatter(score(65:end,1),score(65:end,2),'d');

scatter(score(poi,1),score(poi,2),150,'y');
title('PCA')

cluster = find((score(:,1)>-1.2) & (score(:,1)< 0.5) & (score(:,2)<0) & (score(:,2)>-1.5));

figure; scatter(score(1:end,1),score(1:end,2),'o'); hold on;
scatter(score(cluster,1),score(cluster,2),'o','filled');

figure;
for i = 1:length(cluster)
    indx = cluster(i);
%     plot_fo(data(indx,:),reference,profiles(indx,:),Ts); hold on;
    plot(profiles(indx,:)); hold on;
end

cluster2 = find((score(:,1)>0.5)); 

figure; scatter(score(1:end,1),score(1:end,2),'o'); hold on;
scatter(score(cluster2,1),score(cluster2,2),'o','filled');

figure;
for i = 1:length(cluster2)
    indx = cluster2(i);
%     plot_fo(data(indx,:),reference,profiles(indx,:),Ts); hold on;
    plot(profiles(indx,:)); hold on;
end

% figure;
% scatter3(score(1:20,1),score(1:20,2),score(1:20,3),'o'); hold on;
% scatter3(score(21:52,1),score(21:52,2),score(21:52,3),'v');
% scatter3(score(53:64,1),score(53:64,2),score(53:64,3),'x');
% scatter3(score(65:end,1),score(65:end,2),score(65:end,3),'d');