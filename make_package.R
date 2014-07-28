setwd("clockstarG_code/")
funs <- grep('R$', dir(), value = T)
for(i in funs) source(i)
setwd('..')

package.skeleton(name = 'ClockstaRG')


