for yyyyy = 1:47
clc;
%读取数据
dir = ['NOAA_wind_brw (1)/met_brw_insitu_1_obop_hour_',num2str(yyyyy+1972),'.txt'];
data_r = importdata(dir);
data = data_r.data;

%数据筛选
for i = 1:size(data(:,6),1)
    if data(i,6) < 0 
        data(i,:) = -1;
    end
end

id_1 = find(data(:,6) == -1);
data(id_1,:) = nan;

%数据按日期汇总求平均
[Groups,month,day] = findgroups(data(:,2),data(:,3));
S = splitapply(@mean,data(:,6),Groups);

% % % % % % 绘图
x = 1:size(data(:,6),1);

figure('Units','centimeter','Position',[5 5 28 13]);

% yyaxis left
plot(x,data(:,6),'-b','linewidth',1);
axis([0,size(data(:,6),1),0,20]);
ylabel('wind speed (m/s)');

yticks = linspace(0,20,5);
set(gca,'YTick',yticks);

year = num2str(data(1,1));
% xticks = [1,find(month==1,1,'last'),find(month==2,1,'last'),find(month==3,1,'last'),find(month==4,1,'last'),find(month==5,1,'last'),find(month==6,1,'last')...
%     find(month==7,1,'last'),find(month==8,1,'last'),find(month==9,1,'last'),find(month==10,1,'last'),find(month==11,1,'last'),find(month==12,1,'last')];
xticks = linspace(1,size(data(:,6),1),13);
% xticklabels = {year,[year,'.1'],'2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月'};
xticklabels = {year,[year,'.1'],[year,'.2'],[year,'.3'],[year,'.4'],[year,'.5'],[year,'.6'],[year,'.7'],[year,'.8'],[year,'.9'],[year,'.10'],[year,'.11'],[year,'.12']};
% xtickangle(50);%xlabels旋转
set(gca,'XTick',xticks);
set(gca,'XTickLabel',xticklabels);

title([year,'年风速时间序列']);

hold on
plot([0,size(data(:,6),1)],[mean(data(:,6),'omitnan'),mean(data(:,6),'omitnan')],'r' ,'linewidth',1);

saveas(gcf, [year,'年风速时间序列'], 'png');
clear;
end