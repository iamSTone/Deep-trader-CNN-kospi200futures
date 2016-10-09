load("k200fut.RData")  

fut$day_roc = fut$close/Lag(fut$close)-1
fut$class = ifelse(fut$day_roc > 0.005,1,ifelse(fut$day_roc < -0.005,-1,0)) 
win = 20;
sd = 2

bb = BBands(fut$close,n = win, sd =sd)
bb$width = (bb$up-bb$dn)/bb$mavg  # width
bb = na.omit(bb)
bb$squeeze = rollapply(bb$width,width=60,function(x) quantile(x,prob=0.03), by=1,align = 'right') 
df = cbind(fut,bb)
df = na.omit(df)
df$bb = ifelse(df$close > df$up,0.5,ifelse(df$close < df$dn,-0.5,0))

for (i in 1:4) {
  df[,i] = df[,i]/df$mavg - 1
}
df = df[,c("open","high","low","close","bb","pctB","squeeze","width","class")]
df_train = df

rollingwindow = 8
ff_all = ffl_all = NULL
for ( i in 1:(nrow(df_train)-rollingwindow))  {
  # feature
  ff = df_train[i:(i+rollingwindow-1),-ncol(df)]   
  ff=data.frame(ff)
  row.names(ff) = colnames(ff) = NULL
  ff_flat = unlist(ff)  
  ff_all = rbind(ff_all,ff_flat)
  
  # label
  ffl = df_train[i+rollingwindow,"class"]
  ffl$c3 = ffl$c2 = ffl$c1 = 0
  ffl$c1 = ifelse(ffl$class == 1,1,ffl$c1)
  ffl$c2 = ifelse(ffl$class == 0,1,ffl$c2)
  ffl$c3 = ifelse(ffl$class == -1,1,ffl$c3)
  ffl = ffl[,2:4]
  ffl=data.frame(ffl)
  row.names(ffl) = colnames(ffl) = NULL
  ffl_flat = unlist(ffl) 
  ffl_all = rbind(ffl_all,ffl_flat)
}
write.table(round(ff_all,5),"C:/Users/home/Desktop/df_train_feature.csv",row.names = F,col.names = F,sep=",")
write.table(ffl_all,"C:/Users/home/Desktop/df_train_label.csv",row.names = F,col.names = F,sep=",")
