gas.data <- read.csv('data/gas.data.reformatted.csv')
View(gas.data)

max.gas.prices <- gas.data %>% 
  select(Date, City, Gas.Prices..dollars.per.gallon.) %>% 
  group_by(City) %>% 
  filter(Gas.Prices..dollars.per.gallon. == max(Gas.Prices..dollars.per.gallon., na.rm = TRUE))
View(max.gas.prices)

min.gas.prices <- gas.data %>% 
  select(Date, City, Gas.Prices..dollars.per.gallon.) %>% 
  group_by(City) %>% 
  filter(Gas.Prices..dollars.per.gallon. == min(Gas.Prices..dollars.per.gallon., na.rm = TRUE))
View(min.gas.prices)

max.gas.prices.plot <- ggplot(max.gas.prices) +
  geom_point(aes(x = Date, y = Gas.Prices..dollars.per.gallon., col = City)) +
  labs(x = 'Date', y = 'Gas Price (dollars per gallon)')
