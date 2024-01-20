%%
%data in
clc;
fnshp_P='D:\matlabproject\region.shp';

infoP = shapeinfo(fnshp_P);

readP=shaperead(fnshp_P);

bb = xlsread('d:/matlabproject/0205/hndata.xlsx',1,'A1:U9');

S = shaperead(fnshp_P);

n=1;

while (n>=1 && n<=numel(S))
    sname=S(n).NAME;
    if ( ~strcmp(sname,'海南'))
        S(n)=[ ];
        n=n-1;
    end
        n=n+1;
end

clc;
X = [S.X];
Y = [S.Y];


figure(1)


hold on

xx = linspace(min(X(1,:)),max(X(1,:)),500);
yy = linspace(min(Y(1,:)),max(Y(1,:)),500);
yy = yy';

jj = 1;
while(jj>=1&&jj<=500)
    xx(jj,:) = xx(1,:);
    jj = jj+1;
end

jj = 1;
while(jj>=1&&jj<=500)
    yy(:,jj) = yy(:,1);
     jj = jj+1;
end

zz = griddata(bb(:,6),bb(:,5),bb(:,18),xx,yy);%%%%%

contourf(xx,yy,zz,10,'lines','no');
caxis([60,95]);

i = 1;
while (i >=1 && i <=5)
    str = {bb(i,18)};%%%%%
    text(bb(i,6)-0.05,bb(i,5)+0.1,str,'FontSize',5,'Color','k');
    plot(bb(i,6),bb(i,5),'r.');
    i = i+1;
end

plot(X,Y,'-k','LineWidth',1);
%title('改进前海南省12月');%%%%%

set(gca,'XTick',[109:1:111],'XTickLabel',{'109°E';'110°E';'111°E'})
set(gca,'YTick',[19,20],'YTickLabel',{'19°N';'20°N'})
colorbar('fontsize',10);