function [net_tr,tr] = trainFeedForward(layDim, trainingData, trainingOutput)

    net = feedforwardnet(layDim);

    for i = 2:length(net.layers)-1
        net.layers{i}.transferFcn = 'poslin';
    end
    
    net = configure(net, trainingData);
    
    [net_tr,tr] = train(net, trainingData, trainingOutput);

end

