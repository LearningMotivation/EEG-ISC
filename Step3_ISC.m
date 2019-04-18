%% ������ Inter-subject correlation

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%�ű�������������%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% 3.0 ������(���������б���ȱʧ����/��ֵά�Ȳ�ƥ�䡱���ص��ⲽ���µ��룩
%%%%% 3.1 ISC for single video (full duration)                    %%%%%%%%%
%%%%% 3.2 ISC for single video (cumulative duration)              %%%%%%%%%
%%%%% 3.3 ISC for video set (combinedata, full dutration)         %%%%%%%%%
%%%%% 3.4 ISC for video set (combinedata, cumulative duration)    %%%%%%%%%
%%%%% 3.5 Topoplot
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 3.0 ����
clear;clc

allsub_No = [1:20]; %���б��Ա��
badsub_No = [4,9,13,16,19]; %�쳣���Ա�� %++++++++++++++++++
sub_No = setdiff(allsub_No,badsub_No); %�޳��쳣���Ժ����ں��������ı��Ա��
n = length(sub_No); %���ں��������ı��Ը���

fs = 250; %+++++++++
%m_eogchannels = [33,43,63,64];% m1,m2 + EOG ͨ�����

duration = [100;81;149;129;133;67;123;57;121;133;132;170;215;170;129];
allvideo = 1:15;
videoset_HW = [12,3,6,14];  % HW = high willingness to learn
videoset_LW = [11,9,13,10]; % LW = low willingness to learn
videoset1 = [videoset_HW, videoset_LW]; 

%videoset_HP = [3,15];  % HP = high preference
%videoset_LP = [1,13];  % LP = low preference
%videoset2 = [videoset_HP, videoset_LP]; 

%% 3.1 ISC for single video (full duration)

tic

disp('3. It is time to run ISC!')

load_dir = 'G:/Research (��)/ѡ��_v4/data/6. dataforISC_5sp_5SD_40ms/full duration';
save_dir = 'G:/Research (��)/ѡ��_v4/data/8. ResultsforISC_5sp_5SD_40ms/full duration';
if ~exist(save_dir)
    mkdir(save_dir)
else
end

% ��ʼ�����±���
Ncomp = 3; %�ɷ���
Nvid = numel(allvideo);
isc = zeros(Nvid,1);
isc_percomp = zeros(Ncomp,Nvid);
isc_persubject = zeros(Nvid,n); 
isc_persubject_percomp = zeros(Ncomp,Nvid,n);  
isc_persecond_percomp = cell(Nvid,Ncomp);
%isc_cumsecond_percomp = cell(Nvid,Ncomp);
%isc_cumsec_persubject_percomp = cell(Nvid,Ncomp);%

w = zeros(Nvid,60,Ncomp); % 60Ϊ���ڷ�����ͨ������
a = zeros(Nvid,60,Ncomp);

%for videoi = videoset1(1:numel(videoset1))
for videoi = 1:15
     videoi
     
     cd(load_dir)
     datafile = ['v',num2str(videoi),'_30_2.mat'];
     
     [ISC,ISC_persubject,ISC_persecond,W,A] = runisc(datafile); %setpath runisc_psd.m
     
     isc(videoi,1) = sum(ISC(1:3,1));
     isc_persubject(videoi,:) = sum(ISC_persubject(1:3,:));
    
    for compi = 1:3
        isc_percomp(compi,videoi) = ISC(compi,1);
        isc_persubject_percomp(compi,videoi,:) = ISC_persubject(compi,:);
        isc_persecond_percomp{videoi,compi} = ISC_persecond(compi,:); 
        %isc_cumsecond_percomp{videoi,compi} = ISC_cumsecond(compi,:);
        w(videoi,:,compi) = W(:,compi);
        a(videoi,:,compi) = A(:,compi);
    end
end

cd(save_dir)
save('ISC_allvideo_30s_2.mat','isc','isc_persubject','isc_percomp','isc_persubject_percomp','isc_persecond_percomp','w','a')

disp('3. ISC finished!!')

toc %ʱ���ѹ� 83.241711 �롣

%% 3.2 ISC for single video (cumulative duration)

%%% Ϊ statistical analysis �е� 4.1 [Correlation] single video_cumulative data ��������

tic 

save_dir = 'G:/Research/ѡ��_v3/data/8. ResultsforISC_5sp_5SD_40ms/cumulative duration';
if ~exist(save_dir)
    mkdir(save_dir)
else
end

Ncomp = 3; %�ɷ���
Nvid = 15;
Ncumtime = 67;
isc = zeros(Nvid,1);
isc_percomp = zeros(Ncomp,Nvid);
isc_persubject = zeros(Nvid,n); %����Ϊ16��
isc_persubject_percomp = zeros(Ncomp,Nvid,n);  
%isc_persecond_percomp= cell(Nvidset,Ncomp);  %����cumulative_ISC��û��Ҫ�����ISC_persecond
cumtime_isc = zeros(Nvid,Ncumtime);
cumtime_isc_persubject = zeros(Nvid,n,Ncumtime);


%for videoi = 1 : Nvid
for videoi = videoset1(1:numel(videoset1))
    videoi
for cumtimei = 1 : Ncumtime
    cumtimei      %ָʾ����
    
    load_dir = ['G:/Research/ѡ��_v3/data/6. dataforISC_5sp_5SD_40ms/',num2str(cumtimei),'s'];
    cd (load_dir)
    
    datafile = (['v',num2str(videoi),'.mat']);
    
    [ISC,ISC_persubject] = runisc(datafile); 
    
    %isc(videoi,1)=sum(ISC(1:3,1));
    
    %isc_persubject(videoi,:)=sum(ISC_persubject(1:3,:));
    
    %for compi=1:Ncomp
    %    isc_percomp(compi,videoi)=ISC(compi,1);
    %    isc_persubject_percomp(compi,videoi,:) = ISC_persubject(compi,:);
    %end
    
    cumtime_isc(videoi,cumtimei) = sum(ISC(1:3,1));
    cumtime_isc_persubject(videoi,:,cumtimei) = sum(ISC_persubject(1:3,:));    
    
end  
end

cd(save_dir)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
save('ISC_videoset1.mat','cumtime_isc','cumtime_isc_persubject');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

toc


%% 3.3 ISC for video set (full duration)
tic
disp('3. It is time to run ISC!')
load_dir = 'L:/Research/ѡ��_v3/data/7. combinedataforISC/full duration';
save_dir = 'L:/Research/ѡ��_v3/data/8. ResultsforISC/full duration';
if ~exist(save_dir)
    mkdir(save_dir)
else
end

cd(load_dir)

Ncomp = 3; %�ɷ���
Nvidset = 2;

isc = zeros(Nvidset,1);
isc_percomp = zeros(Ncomp,Nvidset);
isc_persubject = zeros(Nvidset,n); %����Ϊ16��
isc_persubject_percomp = zeros(Ncomp,Nvidset,n);  
%isc_persecond_percomp= cell(Nvidset,Ncomp);  
w = zeros(Nvidset,60,Ncomp); % 60Ϊ���ڷ�����ͨ������

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
videosets = ['HW_video';'LW_video'];
%videosets =['HP_video';'LP_video'];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for vseti = 1 : Nvidset
    
    cd (load_dir)
    
    datafile = ([videosets(vseti,:),'.mat']);
    
    [ISC,ISC_persubject,~,W,A] = runisc(datafile); 
    
    isc(vseti,1)=sum(ISC(1:3,1));
    
    isc_persubject(vseti,:)=sum(ISC_persubject(1:3,:));
    
    for compi=1:Ncomp
        isc_percomp(compi,vseti)=ISC(compi,1);
        isc_persubject_percomp(compi,vseti,:) = ISC_persubject(compi,:);
        w(vseti,:,compi) = W(:,compi);
        a(vseti,:,compi) = A(:,compi);
    end
    
end  

cd(save_dir)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
save('ISC_videoset11.mat','isc','isc_persubject','isc_percomp','isc_persubject_percomp','w','a');
%save('ISC_videoset2.mat','isc','isc_persubject','isc_percomp','isc_persubject_percomp','w','a');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('3. ISC finished!!')

toc %ʱ���ѹ� 32.581121 �롣

%% 3.4 ISC for video set (cumulative duration)
tic
save_dir = 'H:/Research/ѡ��_v3/data/8. ResultsforISC_5sp_5SD_40ms/cumulative duration';  %+++++++
if ~exist(save_dir)
    mkdir(save_dir)
else
end


Ncomp = 3; %�ɷ���
Nvidset = 4;
%%%%%%%%%%%%%%%%%%%%%%%%%%%
Ncumtime = 133;
%Ncumtime = 100;
%%%%%%%%%%%%%%%%%%%%%%%%%%%
isc = zeros(Nvidset,1);
isc_percomp = zeros(Ncomp,Nvidset);
isc_persubject = zeros(Nvidset,n); %����Ϊ16��
isc_persubject_percomp = zeros(Ncomp,Nvidset,n);  
%isc_persecond_percomp= cell(Nvidset,Ncomp);  %����cumulative_ISC��û��Ҫ�����ISC_persecond
cumtime_isc = zeros(Nvidset,Ncumtime);
cumtime_isc_persubject = zeros(Nvidset,n,Ncumtime);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%videosets = ['HW_video';'LW_video'];
videosets = ['v12';'v03';'v10';'v13'];
%videosets =['HP_video';'LP_video'];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for vseti = 1 : Nvidset
    vseti  %ָʾ����
for cumtimei = 1:Ncumtime
    cumtimei      %ָʾ����
    
    load_dir = ['H:/Research/ѡ��_v3/data/6. dataforISC_5sp_5SD_40ms/',num2str(cumtimei),'s'];  %------
    
    cd (load_dir)                                                   %------
    datafile = ([videosets(vseti,:),'.mat']);
    
    [ISC,ISC_persubject] = runisc(datafile); 
    
    %isc(vseti,1) = sum(ISC(1:3,1));
    
    %isc_persubject(vseti,:) = sum(ISC_persubject(1:3,:));
    
    %for compi=1:Ncomp
    %    isc_percomp(compi,vseti)=ISC(compi,1);
    %    isc_persubject_percomp(compi,vseti,:) = ISC_persubject(compi,:);
        %isc_persecond_percomp{seti,compi} = ISC_persecond(compi,:);
    %end
    cumtime_isc(vseti,cumtimei) = sum(ISC(1:3,1));
    cumtime_isc_persubject(vseti,:,cumtimei) = sum(ISC_persubject(1:3,:));    
    
    clear X
end  
end

cd(save_dir)                                                       %+++++++
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
save('ISC_videoset4.mat','cumtime_isc','cumtime_isc_persubject');
%save('ISC_videoset2.mat','cumtime_isc','cumtime_isc_persubject');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


toc %ʱ���ѹ� 2244.668110 �롣


%% 3.5 topoplot
Ncomp = 3;

if ~exist('topoplot') | ~exist('notBoxPlot')
    warning('Get display functions topoplot, notBoxPlot where you found this file or on the web');
else
    for i=1:Ncomp
        subplot(1,Ncomp,i);
        topoplot(squeeze(a(12,:,i)),'Neuroscan64.loc'); %video 12
        set(gca,'clim',[-0.6 0.6])
        %colorbar
    end
end
load color_map2
colormap(color_power)

    for i =1:3
         subplot(1,Ncomp,i);
         topoplot(squeeze(a(10,:,i)),'Neuroscan64.loc'); %video 10
         set(gca,'clim',[-0.6 0.6])
         %colorbar
    end
%end

topoplot(squeeze(a(10,:,1)),'Neuroscan64.loc'); %video 10
set(gca,'clim',[-0.6 0.6])
colorbar
         
%for i=1:Ncomp
%        subplot(1,Ncomp,i);
%        topoplot(squeeze(a(1,:,i)),'Neuroscan64.loc'); %title(['a_' num2str(i)])
%        set(gca,'clim',[-0.35 0.35])
        %colorbar
%end











