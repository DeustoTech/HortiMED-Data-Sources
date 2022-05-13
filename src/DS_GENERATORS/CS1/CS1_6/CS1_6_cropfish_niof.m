clear
%
params.Number_Tilapia = 450;
params.Number_Mullet = 500;
params.Number_Cray = 165;
params.Number_Clams = 176;
params.Number_Silver = 650;

first_day = datetime('01-May-2021');
%
%                      %time[d]       % Fish Mass [g/fish]      % Fish Mass STD[g/fish]  % Feed Intake [g/(days . fish)]    % Gain   [g/(fish . period)        % FCR
data_aquaponic = [     0               30                          6.37                       18                              0                                   0       ; ...
                       30              57.39                       9.47                       34.43                           16.43                               1.10    ; ...
                       60              71.94                       10.28                      43.16                           8.73                                3.94    ; ...
                       90              90.7                        7.974                      54.30                           11.14                               3.87    ; ...
                       120             121.3                       6.74                       72.78                           18.48                               2.94    ; ...
                       150             164.16                      8.89                       98.5                            25.72                               2.83    ; ...
                       180             198.58                      6.12                       119.15                          20.65                               4.77];
%

MulletMass = [ 1.14	2.83	4.02	7.5	12.59	17.32	20.18];
MulletMassErr = [ 0.74	1.17	1.08	1.08	2.17	1.67	1.59];

CrayMass    = [nan	nan nan 16.19	20.08	25.46	28.04];
CrayMassErr = [nan	nan nan	3.11	3.85	2.44	5.28];

ClamsMass    = [nan	nan	210	250.33	275.17	309.58	355.67];
ClamsMassErr = [nan	nan	61.77	64.18	59.67	46.86	37.69];

SilverMass    = [nan	nan	3.65	8.68	13.36	19.5	22.41];
SilverMassErr = [nan	nan	2.99	2.2	    4.69	4.55	4.04];

data_aquaponic = array2table(data_aquaponic,'VariableNames',{'days','TilapiaMass','TilapiaMassErr','FeedTilapiaIntake','GainTilapia','FCRTilapia'});
data_aquaponic.Properties.VariableUnits = {'days','g/fish','g/fish','g/(days . fish)','g/(fish . period)','-'};

clear data_aquaponic_2
%
data_aquaponic_2.MulletMass = MulletMass';
data_aquaponic_2.MulletMassErr = MulletMassErr';

data_aquaponic_2.ClamsMass = ClamsMass';
data_aquaponic_2.ClamsMassErr = ClamsMassErr';

data_aquaponic_2.CrayMass = CrayMass';
data_aquaponic_2.CrayMassErr = CrayMassErr';

data_aquaponic_2.SilverMass = SilverMass';
data_aquaponic_2.SilverMassErr = SilverMassErr';

data_aquaponic_2 = struct2table(data_aquaponic_2);

data_aquaponic = [data_aquaponic data_aquaponic_2];
data_aquaponic.DateTime = days(data_aquaponic.days) + first_day;
%%
figure(1)
clf
names = {'Tilapia','Mullet','Clams','Silver','Cray'}

subplot(2,1,1)
hold on 
for iname = names;
errorbar(data_aquaponic.DateTime,data_aquaponic.(iname{:}+"Mass"),data_aquaponic.(iname{:}+"MassErr"),'LineWidth',2)
end
ylabel('g/fish')
legend(names)
grid on

subplot(2,1,2)
hold on 
for iname = names
    nspecie = params.("Number_"+iname{:});
plot(data_aquaponic.DateTime,data_aquaponic.(iname{:}+"Mass")*nspecie/1000,'LineWidth',2,'Marker','o')
end
ylabel('kg')
legend(names)
grid on
%%
