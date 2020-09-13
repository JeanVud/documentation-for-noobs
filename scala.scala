import com.twitter.util.Config.intoList
import org.apache.hadoop.fs.{FileSystem, Path}
import org.apache.spark.rdd.RDD
import org.apache.spark.sql.functions.{col, from_json, regexp_extract}
import org.apache.spark.sql.types.{StringType, StructType}
import org.apache.spark.sql.{DataFrame, SparkSession}
import org.apache.spark.sql.functions.split

object fplay {

  def main(args: Array[String]): Unit = {
    println(12324232)

    val spark: SparkSession = SparkSession.builder()
      .master("local[*]")
      .appName("")
      .config("spark.io.compression.codec", "snappy")
      .getOrCreate()

    val df = parserData(spark, "/home/giangvdq/Downloads/logstash240.02.log.gz")

//    df.show()
    //parserLog(spark, df)

    temp()


    //saveParquet(df,spark)

    //displayParquet(spark)

    spark.stop()
  }

  def parserData(spark: SparkSession, pathInput: String): DataFrame = {
    import spark.implicits._
    //Read log file from path
    val df = spark.read.text(pathInput)

    //Define struct
    val schema = new StructType()
      .add("hostname", StringType, true)
      .add("@timestamp", StringType, true)
      .add("body_bytes_sent", StringType, true)
      .add("remote_addr", StringType, true)
      .add("request_length", StringType, true)
      .add("isp", StringType, true)
      .add("server_protocol", StringType, true)
      .add("bytes_sent", StringType, true)
      .add("@version", StringType, true)
      .add("status", StringType, true)
      .add("receive_time", StringType, true)
      .add("request_method", StringType, true)
      .add("host", StringType, true)
      .add("services", StringType, true)
      .add("request_uri", StringType, true)
      .add("http_user_agent", StringType, true)
      .add("source_host", StringType, true)
      .add("server_port", StringType, true)
      .add("request_time", StringType, true)


    val dfJSON = df.withColumn("jsonData", from_json(col("value"), schema))
      .select("jsonData.*")
    dfJSON

    // explode JSON column containing a sequence of JSON elements
    // https://stackoverflow.com/questions/50500032/use-from-json-in-scala-to-parse-multiple-rows-in-a-dataframe
  } //read by json format
  def displayParquet(spark: SparkSession): Unit = {
    val par = spark.read.parquet("/home/giangvdq/Downloads/log.parquet/part-00000-d03938a6-b9cf-4705-81a4-03b68b7d6646-c000.snappy.parquet")
    par.createOrReplaceTempView("parquetFile")
    val namesDF = spark.sql("SELECT * FROM parquetFile")
    namesDF.show()
  }

  def saveParquet(df: DataFrame, spark: SparkSession): Unit = {
    df.write.parquet("/home/giangvdq/Downloads/log.parquet")
  }

  def parserLog(spark: SparkSession, df: DataFrame) {

    val col = "request_uri"
    //val dfLog = df.select("request_uri")
    val tempDF = df.select(col)
    tempDF.show()

    // Split a string and index a field
//    val parse_city: (Column) => Column = (x) => { split(x, "-")(1) }
//    df = df.withColumn("city", parse_city(col("location")))
    var df3 = tempDF.withColumn(col, split(tempDF(col),"\\."))
    df3 = df3.select(
      df3(col).getItem(0).as("col1"),
      df3(col).getItem(1).as("col2"),
      df3(col).getItem(2).as("col3"))
    //df3.show()

    var logDF = df.select(col)

    logDF = logDF.withColumn(col, split(logDF(col), "\\&"))

    var x = 1
    logDF = logDF.select(
      logDF(col).getItem(0).as("col1"),
      logDF(col).getItem(1).as("col2"),
      logDF(col).getItem(2).as("col3")
    )
    x = 2
    logDF.show()



    //val result = csv.flatMap { case Array(s1, s2, s3, s4) => s2.split(" ").map(part => (s1, part, s3, s4)) }






//
//    val newDF = dfLog.map(f => {
//      val nameSplit = f.getAs[String](0).split(",")
//      val addSplit = f.getAs[String](1).split(",")
//      (nameSplit(0), nameSplit(1), addSplit(0), addSplit(1), addSplit(2), addSplit(3))
//    })
//    val finalDF = newDF.toDF("First Name", "Last Name",
//      "Address Line1", "City", "State", "zipCode")
//
//    val list = List("one", "two", "three")
//    val lengths = list.map(_.length)

    // input: dataframe một dòng, mỗi dòng là string gồm "/i?.."
    // output: tách từng dòng trong string ra theo từng field
    // note: không phải chuỗi nào cũng có các trường được sắp xếp theo thứ tự

    // the important thing is geting the job done lmao even if it's a little memory consuming

    // plan of execution:
    // foreach row in df: đọc từng dòng
    // row.split(delimiter = "&") into an array of fields
    // rồi sao nữa????? help
    // lưu kiểu gì vào file?? stream từng dòng??? file stream vô parquet hay json
  }
  def temp(): Unit ={
    val spark: SparkSession = SparkSession.builder()
      .master("local[*]")
      .appName("")
      .config("spark.io.compression.codec", "snappy")
      .getOrCreate()
    import spark.implicits._

    val columns = Seq("name","address")
    val data = Seq(
      ("Robert, Smith", "1 Main st, Newark, NJ, 92537"),
      ("Maria, Garcia","3456 Walnut st, Newark, NJ, 94732")
    )
    var dfFromData = spark.createDataFrame(data).toDF(columns:_*)
    dfFromData.printSchema()

    val newDF = dfFromData.map( f => {
      val nameSplit = f.getAs[String](0).split(",")
      val addSplit = f.getAs[String](1).split(",")
      (nameSplit(0),nameSplit(1),addSplit(0),addSplit(1),addSplit(2),addSplit(3))
      }
    )
    val finalDF = newDF.toDF("First Name","Last Name",
      "Address Line1","City","State","zipCode")
    finalDF.printSchema()
    finalDF.show(false)
  }
  def temp2(): Unit = {

    //https://www.geeksforgeeks.org/anonymous-functions-in-scala/#:~:text=In%20Scala%2C%20An%20anonymous%20function,to%20create%20an%20inline%20function.
    // A function which contain anonymous
    // function as a parameter
    def myfunction(fun :(String, String) => String) =
    {
      fun("Dog", "Cat")
    }

    // Explicit type declaration of anonymous
    // function in another function
    val f1 = myfunction((str1: String,
                         str2: String) => str1 + str2)

    // Shorthand declaration using wildcard
    val f2 = myfunction(_ + _)
    println(f1)
    println(f2)
  }
}
