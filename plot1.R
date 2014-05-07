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

# Convert dates in YYYY/mm/dd format
df$Date <- strptime(df$Date, "%d/%m/%Y")

# Now create the plot

hist(df$Global_active_power,col="Red", main = "Global Active Power", xlab="Global Active Power (kilowatts)")

# And save it to png file
dev.copy(png, file="plot1.png", width=480, height=480)
dev.off()
