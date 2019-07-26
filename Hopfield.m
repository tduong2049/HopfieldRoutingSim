clear;
clc;

nodeCount = 8;
sourceNode = 1;
destinationNode = 8;

pathInclusionMat = zeros(8);
pathInclusionMat(1, 2) = 1;
pathInclusionMat(1, 5) = 1;
pathInclusionMat(2, 3) = 1;
pathInclusionMat(2, 4) = 1;
pathInclusionMat(3, 7) = 1;
pathInclusionMat(3, 8) = 1;
pathInclusionMat(4, 6) = 1;
pathInclusionMat(4, 7) = 1;
pathInclusionMat(5, 4) = 1;
pathInclusionMat(6, 5) = 1;
pathInclusionMat(7, 8) = 1;
pathInclusionMat(8, 6) = 1;

connectionMat = ones(8) - pathInclusionMat;

delayMat = [999, 0.3,  999,  999,  0.3,  999, 999,  999;
            999, 999, 0.55, 0.25,  999,  999, 999,  999;
            999, 999,  999,  999,  999,  999, 0.3, 0.25;
            999, 999,  999,  999,  999, 0.55, 0.0,  999;
            999, 999,  999,  0.3,  999,  999, 999,  999;
            999, 999,  999,  999,  0.0,  999, 999,  999;
            999, 999,  999,  999,  999,  999, 999,  0.0;
            999, 999,  999,  999,  999,  0.0, 999,  999];
            
totalDelay = sum(sum(delayMat.*pathInclusionMat));
maxDelay = totalDelay;
            
costMat = delayMat;
totalCost = sum(sum(costMat.*pathInclusionMat));

terms = [1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000];

energy = getEnergy(nodeCount, sourceNode, destinationNode, terms, 
                   pathInclusionMat, connectionMat, delayMat, maxDelay, costMat)

for count1 = 1:3
  inputMat = randi(2, nodeCount, nodeCount) -1;
  stateMat = 1./(1 + exp(-1 * inputMat));
  stateMat = stateMat - diag(diag(stateMat));
  
  for count2 = 1:10000
    derSum = 0;
    
    for i = 1:nodeCount
      for j = 1:nodeCount
        for k = 1:nodeCount
          for l = 1:nodeCount
            if (l != k)
              