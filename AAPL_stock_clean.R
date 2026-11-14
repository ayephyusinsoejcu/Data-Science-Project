
# Import original Kaggle dataset

stock <- read.csv(
  file.choose(),
  stringsAsFactors = FALSE,
  na.strings = c("", "NA")
)

cat("Original dataset dimensions:\n")
print(dim(stock))
print(head(stock, 3))


# Convert Date to Date format

stock$Date <- as.Date(
  stock$Date,
  format = "%Y-%m-%d"
)

# Remove extra row without a valid date
stock <- stock[!is.na(stock$Date), ]


# Convert numeric columns

numeric_cols <- c(
  "Open", "High", "Low", "Close", "Volume"
)

stock[numeric_cols] <- lapply(
  stock[numeric_cols],
  as.numeric
)


# STEP 4: Check data quality

cat("\nMissing values:\n")
print(colSums(is.na(stock)))

cat("\nDuplicate dates:\n")
print(sum(duplicated(stock$Date)))

# Stop if important stock values are missing
if (anyNA(stock[numeric_cols])) {
  stop("Check missing numeric values before continuing.")
}

# Stop if duplicate dates have conflicting values
if (any(duplicated(stock$Date))) {
  stop("Duplicate dates found. Inspect before removing.")
}

# Check that prices and volume are valid
invalid <- with(stock,
                is.na(Open) | is.na(High) |
                  is.na(Low) | is.na(Close) |
                  is.na(Volume) |
                  Open <= 0 | High <= 0 |
                  Low <= 0 | Close <= 0 |
                  Volume < 0 |
                  High < Low |
                  High < Open | High < Close |
                  Low > Open | Low > Close
)

if (any(invalid)) {
  stop("Invalid stock prices or volume found.")
}

# Sort chronologically
stock <- stock[order(stock$Date), ]
rownames(stock) <- NULL


# STEP 5: Create time-based attributes

stock$Year <- as.integer(
  format(stock$Date, "%Y")
)

stock$Month <- format(
  stock$Date, "%Y-%m"
)

stock$Quarter <- paste0(
  "Q",
  (as.integer(format(stock$Date, "%m")) - 1) %/% 3 + 1
)


# STEP 6: Calculate daily price range

stock$Price_Range <-
  stock$High - stock$Low


# STEP 7: Calculate daily percentage return

stock$Daily_Return <- c(
  NA_real_,
  stock$Close[-1] /
    head(stock$Close, -1) - 1
)


# STEP 8: Calculate 30-day moving average

stock$MA30 <- as.numeric(
  stats::filter(
    stock$Close,
    rep(1 / 30, 30),
    sides = 1
  )
)


# STEP 9: Calculate absolute daily return

stock$Absolute_Return <-
  abs(stock$Daily_Return)


# STEP 10: Validate final dataset

cat("\nCleaned dataset dimensions:\n")
print(dim(stock))

cat("\nDate range:\n")
print(range(stock$Date))

cat("\nMA30 column type:\n")
print(class(stock$MA30))

cat("\nMissing MA30 values:\n")
print(sum(is.na(stock$MA30)))

cat("\nSummary:\n")
print(summary(stock))


# STEP 11: Export corrected dataset
# Missing values must be blank, not text "NA"

write.csv(
  stock,
  "AAPL_cleaned.csv",
  row.names = FALSE,
  na = ""
)

cat("\nExport successful:\n")
print(file.exists("AAPL_cleaned.csv"))

cat("\nSaved location:\n")
print(getwd())



# ANNUAL STOCK RETURNS
# Group stock records by year
annual <- do.call(
  rbind,
  lapply(split(stock, stock$Year), function(d) {
    data.frame(
      Year = d$Year[1],
      Annual_Return =
        tail(d$Close, 1) / d$Close[1] - 1
      )
  }
  )
)

rownames(annual) <- NULL

# Display annual returns
print(annual)

# Export annual return dataset
write.csv(
  annual,
  "AAPL_annual_returns.csv",
  row.names = FALSE
)

# Confirm file exists
file.exists("AAPL_annual_returns.csv")



# MONTHLY VOLATILITY
monthly <- aggregate(
  Daily_Return ~ Month,
  data = stock,
  FUN = sd,
  na.action = na.omit
)

# Rename result column
names(monthly)[2] <- "Volatility"

# Display first records
head(monthly)

# Export monthly volatility dataset
write.csv(
  monthly,
  "AAPL_monthly_volatility.csv",
  row.names = FALSE
)

# Confirm file exists
file.exists("AAPL_monthly_volatility.csv")

file.exists("AAPL_cleaned.csv")
file.exists("AAPL_annual_returns.csv")
file.exists("AAPL_monthly_volatility.csv")

tail(monthly, 5)
max(monthly$Month)

write.csv(
  monthly,
  "AAPL_monthly_volatility.csv",
  row.names = FALSE,
  na = ""
)
