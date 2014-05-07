#unzip("./data/exdata_data_household_power_consumption.zip", exdir="./data")
# this code asumes that zip file is extracted
# into data subfolder of working R directory
# use getwd() R command to check current R directory

library("sqldf")
file_to_import = "./data/household_power_consumption.txt"
# SQL Code to select proper data
sql_query= "SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'"

# Now code imports data for dates 1/2/2007 and 2/2/2007
df = read.csv.sql(file_to_import, sql=sql_query, header=T, sep=";")

# x variable is used to  concatenate Date and Time 
x <- paste(as.Date(df$Date, "%d/%m/%Y"), df$Time)

# convert x to appropriate date format
x<- strptime(x, "%Y-%m-%d %H:%M:%S")

# Initialize the png file
png("plot3.png", width = 480, height = 480)

# Now create the third plot plot
plot(x, as.numeric(df$Sub_metering_1), type="l",
     ylab="Energy Submetering", xlab="")
lines(x, as.numeric(df$Sub_metering_2), type="l", col="red")
lines(x, as.numeric(df$Sub_metering_3), type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd =2.5,
       col=c("black", "red", "blue"))


# And close the png file
dev.off()

