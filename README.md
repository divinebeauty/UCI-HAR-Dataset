1. Libraries are called.
2. Datasets of test and train are then merged.
3. Headers are copied from features.txt.
4. Only those columns are grepped which includes data on mean and standard deviation.
5. Activity labels are introduced using activity_labels.txt file.
6. Subject column is added using cbind to final dataset.
7. Redundant punctuations are removed from final dataset.
8. Average for each measurement is calculated at for each subject and each activity.
9. Final file is then written using write.table().









