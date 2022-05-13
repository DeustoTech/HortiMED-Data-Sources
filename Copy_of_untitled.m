clear
load('CS1_2_renile')
%
clf
plot(data.DateTime,data.ambient_temp_Biological_filter_P_5)

hourtime = hour(data.DateTime) + minute(data.DateTime)/60;
hourtime = cos(hourtime) ;
%
tspan = days(data.DateTime - data.DateTime(1));

%
Te = data.ambient_temp_Biological_filter_P_5;
Rad = data.Rad/800;
%
%day_night = tanh(Rad-50);
%Rad = day_night;
%Rad = smoothdata(Rad,'gaussian','SmoothingFactor',0.5)
%
tspan(isnan(Te)) = [];
Rad(isnan(Te)) = [];
hourtime(isnan(Te)) = [];
Te(isnan(Te)) = [];

Te_sm = smoothdata(Te,'lowess','SmoothingFactor',0.2);
%
dTe = gradient(Te_sm,tspan);
dTe_sm = smoothdata(dTe,'lowess','SmoothingFactor',0.05);

ddTe = gradient(dTe_sm,tspan);
ddTe_sm = smoothdata(ddTe,'lowess','SmoothingFactor',0.05);
%
dddTe = gradient(ddTe_sm,tspan);
dddTe_sm = smoothdata(dddTe,'lowess','SmoothingFactor',0.05);
%

data = [Te_sm dTe_sm ddTe_sm dddTe_sm];
data = [Te_sm dTe_sm ddTe_sm];

%data = Te_sm
%%
clf
plot(Te_sm)
yyaxis right
plot(Rad)

%%
mu = mean(data);
st = std(data);
%
norm_data = (data-mu)./st;
%%
subplot(4,1,1)
plot(tspan,Te_sm)
subplot(4,1,2)
plot(tspan,dTe_sm)
subplot(4,1,3)
plot(tspan,ddTe_sm)
subplot(4,1,4)
plot(tspan,dddTe_sm)
%%
numChannels = size(data,2);
layers = [
    sequenceInputLayer(numChannels+1)
    lstmLayer(32)
    fullyConnectedLayer(numChannels)
    reluLayer
    fullyConnectedLayer(numChannels)
    regressionLayer];

%%
options = trainingOptions("adam", ...
    MaxEpochs=200, ...
    SequencePaddingDirection="left", ...
    Shuffle="every-epoch", ...
    Plots="training-progress", ...
    Verbose=0);
%%
options.InitialLearnRate = 1e-2;
%options.ExecutionEnvironment = 'parallel'
%%
XTrain = [norm_data(1:end-1,:) Rad(1:end-1)];
TTrain = norm_data(2:end,:);

net = trainNetwork(XTrain',TTrain',layers,options);
%% OPen loop
X = XTrain';
T = TTrain';
net = resetState(net);
offset = 1000;
[net,~] = predictAndUpdateState(net,X(:,1:offset));

%
numTimeSteps = size(X,2);
numPredictionTimeSteps = numTimeSteps - offset;
Y = zeros(numChannels,numPredictionTimeSteps);

for t = 1:numPredictionTimeSteps
    Xt = X(:,offset+t);
    [net,Y(:,t)] = predictAndUpdateState(net,Xt);
end
%
figure
t = tiledlayout(numChannels,1);
title(t,"Open Loop Forecasting")

for i = 1:numChannels
    nexttile
    plot(T(i,:))
    hold on
    plot(offset:numTimeSteps,[T(i,offset) Y(i,:)],'--')
    ylabel("Channel " + i)
end

xlabel("Time Step")
nexttile(1)
legend(["Input" "Forecasted"])
%%
Xread = [X(:,1:800)];

net = resetState(net);
offset = size(Xread,2);
[net,Z] = predictAndUpdateState(net,Xread);
%
numPredictionTimeSteps = 1000;
Xt = Z(:,end);
Y = zeros(numChannels,numPredictionTimeSteps);

for t = 1:numPredictionTimeSteps
    [net,Y(:,t)] = predictAndUpdateState(net,[Xt; Rad(offset+t-1)]);
    Xt = Y(:,t);
end
%
numTimeSteps = offset + numPredictionTimeSteps;

figure
t = tiledlayout(numChannels,1);
title(t,"Closed Loop Forecasting")

for i = 1:numChannels
    nexttile
    plot(T(i,1:(offset+numPredictionTimeSteps)))
    hold on
    plot(offset:numTimeSteps,[T(i,offset) Y(i,:)],'--')
    ylabel("Channel " + i)
    yyaxis right 
    plot(Rad(1:(offset+numPredictionTimeSteps)))
end

xlabel("Time Step")
nexttile(1)
legend(["Input" "Forecasted"])
