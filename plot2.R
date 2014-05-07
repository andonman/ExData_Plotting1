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

# Now create the second plot
plot(x, as.numeric(df$Global_active_power), type="l",
     ylab="Global Active Power (kilowatts)", xlab="")

# And save it to png file
dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()
