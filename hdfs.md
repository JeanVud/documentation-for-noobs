get list of directories in hdfs.  
> hdfs dfs -ls /

browse hdfs directory on browser    
> http://localhost:50070/explorer.html#/  

exit namenode safe mode
> hadoop dfsadmin –safemode leave

recursively list all files in the /tmp/hadoop-yarn directory.
> hadoop fs -ls -R /tmp/hadoop-yarn

Show List Output in Human Readable Format  
Human readable format will show each file’s size, such as 1461, as 1.4k.
> hadoop fs -ls -h /user/akbar/input  
> hadoop fs -ls -h tstat-sample.txt

List Information About a Directory  
> hadoop fs -ls -d /user/akbar
