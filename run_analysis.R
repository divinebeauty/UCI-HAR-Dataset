library(tidyr)
library(dplyr)
#merging dataset
a<-read.table("test/X_test.txt")
b<-read.table("train/X_train.txt")
c<-rbind(a,b)
#reading features
d<-read.table("features.txt")
d<-rbind(t(d)[2,],c)
colnames(d)<-d[1,]
d<-d[-1,]
#grepping for only std. and mean measurement columns
m<-c("mean","std")
d<-d[,grep(paste(m, collapse = "|"), colnames(d))]
e<-read.table("test/Y_test.txt")
f<-read.table("train/Y_train.txt")
g<-rbind(e,f)
names(g)<-"ActivityID"
h<-cbind(g,d)
#Reading activity labels
i<-read.table("activity_labels.txt", col.names = c("ActivityID","Activityname"))
h<-merge(i,h, by.y = "ActivityID")
k<-read.table("test/subject_test.txt")
l<-read.table("train/subject_train.txt")
m<-rbind(k,l)
names(m)<-"subject"
#Introducing subject column in main dataset
h<-cbind(m,h)
h<-arrange(h, subject, Activityname)
#Removing redundant punctuations
names(h) <- gsub('\\mean()',"Mean",names(h))
names(h) <- gsub('Freq\\.',"Frequency.",names(h))
names(h) <- gsub('\\()',"",names(h))
names(h) <- gsub('\\-',"",names(h))
names(h) <- gsub("\\ ","", names(h))
#Converting class to numeric from character for all the columns except that of ActivityID, Activityname and subject. These 3 are first 3 columns. Hence, loop starts from column 4.
for(i in c(4:82)){
	h[[i]]<-as.numeric(as.character(h[[i]]))
}
#Calculating mean for each measurement for each subject and activity.
aggregate(h, by = list(h$subject, h$Activityname), FUN = mean, na.rm = TRUE)
#Writing final file
write.table(final, "getting_a1.txt", sep = "\t", dec= ".", col.names = TRUE, eol = "\r")










