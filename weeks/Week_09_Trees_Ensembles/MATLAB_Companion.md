# Week 9 MATLAB Companion — Decision Trees and Ensembles

MATLAB provides tree and ensemble models through the Statistics and Machine Learning Toolbox.

## Regression tree
```matlab
treeModel = fitrtree(Xtrain,ytrain,'MaxNumSplits',20);
ypredTree = predict(treeModel,Xtest);
```

## Visualize the tree
```matlab
view(treeModel,'Mode','graph')
```

## Ensemble of trees
```matlab
ensembleModel = fitrensemble(Xtrain,ytrain,'Method','Bag');
ypredEnsemble = predict(ensembleModel,Xtest);
```

## Compare RMSE
```matlab
rmseTree = sqrt(mean((ytest-ypredTree).^2));
rmseEnsemble = sqrt(mean((ytest-ypredEnsemble).^2));
```

## Feature importance
```matlab
importance = predictorImportance(treeModel);
bar(importance)
xlabel('Feature Number')
ylabel('Importance')
```

A single decision tree is easy to interpret but can overfit. Ensembles combine many trees to improve stability and prediction performance.
