# Week 13 MATLAB Companion — Deep Learning, Text, and AI

MATLAB supports deep learning and text analytics through specialized toolboxes.

## Neural-network concept
A neural network maps inputs through layers to an output:

```text
Engineering inputs → hidden layers → prediction
```

## Simple neural-network regression
With the Statistics and Machine Learning Toolbox:

```matlab
net = fitrnet(Xtrain,ytrain);
ypred = predict(net,Xtest);
```

## Deep Learning Toolbox workflow
A typical MATLAB deep-learning workflow includes:

1. prepare input data;
2. define the network architecture;
3. specify training options;
4. train the network;
5. predict on unseen data;
6. evaluate engineering performance.

## Text analytics
With Text Analytics Toolbox, text can be tokenized and converted into numerical representations before classification.

Typical workflow:

```text
Maintenance note
      ↓
Tokenization
      ↓
Numerical text representation
      ↓
Classifier / neural network
      ↓
Predicted category
```

## LLMs
Large language models can support engineering documentation, summarization, code assistance, and information retrieval, but generated content must be verified against engineering data, standards, and calculations.

MATLAB and Python may use different libraries, but the underlying ML concepts remain the same.
