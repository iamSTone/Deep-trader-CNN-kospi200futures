# Kospi200 index futures Prediction using CNN
This model is a simple and plain work to predict kospi200 index futures prices based on convolutional neural networks.
The python script forecasts tommorrow's kospi200 index futures CLOSE directions. 8 consecutive days' futures prices and other values until today are used as features. 
The purpose of this job is to see if CNN also work properly with financial markets data, not to see its performances.
Most of the codes related to CNN multi layers were picked from  ‘First Contack with TensorFlow‘ written by Jordi Torres.


# 8 Features
1. daily OPEN
2. daily HIGH
3. daily LOW
4. daily CLOSE
5. bolinger band(BB) cross over and down
6. BB percent 
7. BB squeeze
8. BB width

# Data set
Data was used since December, 2007, but I didn't separate data, so you can split it into training sets and test sets.
Data was preprocessed with R.






