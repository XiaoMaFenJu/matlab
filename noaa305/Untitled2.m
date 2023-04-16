clc;clear;
%读取数据
dir = 'NOAA_wind_brw (1)/met_brw_insitu_1_obop_hour_2018.txt';
data_r = importdata(dir);
data = data_r.data;

%数据筛选
for i = 1:size(data(:,6),1)
    if data(i,6) < 0 
        data(i,:) = -1;
    end
%     if data(i,5) < 0 
%         data(i,:) = -1;
%     end
end

id_1 = find(data(:,6) == -1);
data(id_1,:) = nan;
% id_3 = find(data(:,5) == -999);
% data(id_3,:) = nan;
% wind_S = std(data(:,6),0);%无偏估计的标准差 有偏参数1

% h = histogram(data(:,6)); %绘制直方图、结果显示近似正态分布

%三倍标准差
% id_2 = find(data(:,6)  > 3*wind_S);
% data(id_2,:) = [];

% wind_std = (data(:,6) - mean(data(:,6))) / wind_S;

%数据按日期汇总求平均
[Groups,month,day] = findgroups(data(:,2),data(:,3));
S = splitapply(@mean,data(:,6),Groups);

% % % % % % 绘图
x = 1:size(data(:,6),1);

figure('Units','centimeter','Position',[5 5 28 13]);

plot(x,data(:,5),'.','linewidth',0.6,'Color',[217/256 83/256 25/256]);
axis([0,size(data(:,5),1),0,400]);
ylabel('wind direction (degrees)');

yticks_r = linspace(90,360,4);
set(gca,'YTick',yticks_r);
yticklabels_r = {'北','东','南','西'};
set(gca,'YTickLabel',yticklabels_r);

year = num2str(data(1,1));
% xticks = [1,find(month==1,1,'last'),find(month==2,1,'last'),find(month==3,1,'last'),find(month==4,1,'last'),find(month==5,1,'last'),find(month==6,1,'last')...
%     find(month==7,1,'last'),find(month==8,1,'last'),find(month==9,1,'last'),find(month==10,1,'last'),find(month==11,1,'last'),find(month==12,1,'last')];
xticks = linspace(1,size(data(:,6),1),13);
% xticklabels = {year,[year,'.1'],'2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月'};
xticklabels = {year,[year,'.1'],[year,'.2'],[year,'.3'],[year,'.4'],[year,'.5'],[year,'.6'],[year,'.7'],[year,'.8'],[year,'.9'],[year,'.10'],[year,'.11'],[year,'.12']};
% xtickangle(50);%xlabels旋转
set(gca,'XTick',xticks);
set(gca,'XTickLabel',xticklabels);