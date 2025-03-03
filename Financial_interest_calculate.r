pvalue = function(x){
  n = 26
  c = 55
  m = 1000
  p = c*((1-1/(1+x)^n)/x)+(m+c)/(1+x)^n
  p
}


y = 1
price = 1169
while   (pvalue(y) - price > 0.01)
y = y + 0.000001
end
while   (pvalue(y) - price < -0.01)
y = y - 0.000001
end
y
pvalue(y)




#迭代法计算利息
