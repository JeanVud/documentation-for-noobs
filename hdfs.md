get list of directories in hdfs.  
> hdfs dfs -ls /

browse hdfs directory on browser    
> http://localhost:50070/explorer.html#/  

create hdfs directory
> hdfs dfs -mkdir /user

exit namenode safe mode
> hadoop dfsadmin –safemode leave

upload local file to hdfs directory
> hdfs dfs -put /home/hadoopuser/pig_exercise/student_data.txt pig_exercise

recursively list all files in the /tmp/hadoop-yarn directory.
> hadoop fs -ls -R /tmp/hadoop-yarn

copy file from one directory to another
> hdfs dfs -cp old/directory/file new/directory/file

Show List Output in Human Readable Format  
Human readable format will show each file’s size, such as 1461, as 1.4k.
> hadoop fs -ls -h /user/akbar/input  
> hadoop fs -ls -h tstat-sample.txt

List Information About a Directory  
> hadoop fs -ls -d /user/akbar

Display content of file on hdfs to terminal
> hdfs dfs -cat /path/to/file 

Delete hdfs folder/file
> hadoop fs -rm -r /path/to/directory

> https://stackoverflow.com/questions/26216876/find-port-number-where-hdfs-is-listening

> 

## BUG FIXES
### pig connection refused
[Pig and Hadoop connection error](https://stackoverflow.com/questions/28061100/pig-and-hadoop-connection-error)
> ~/hadoop$ cd sbin

> ~/hadoop/sbin$ mr-jobhistory-daemon.sh start historyserver --config $HADOOP_CONF_DIR

starting historyserver, logging to /home/hadoopuser/hadoop/logs/mapred-hadoopuser-historyserver-master.out

> $ jps

6800 Jps
4369 ResourceManager
3922 NameNode
6759 JobHistoryServer
4200 SecondaryNameNode
