.libPaths( c("~/R/x86_64-redhat-linux-gnu-library/2.15", .libPaths()))
is.installed <- function(mypkg) is.element(mypkg, installed.packages()[,1]) 

toInstall <- c("ggplot2", "reshape")
for (package in toInstall){
	if (is.installed(package) == FALSE){
		install.packages(package, repos = "http://cran.r-project.org", lib="~/R/x86_64-redhat-linux-gnu-library/2.15")		
	}
}
lapply(toInstall, library, character.only = TRUE)
minX <- as.integer(commandArgs(TRUE)[1])
maxX <- as.integer(commandArgs(TRUE)[2])

if(file.exists("utimes.txt")){
	df <- read.table("utimes.txt", header = TRUE, check.names = FALSE)
	df <- melt(df, id="time")
	
	df2 <- read.table("utimes_node.txt", header = TRUE, check.names = FALSE)
	df2 <- melt(df2, id="time")
	
	p <- ggplot(df, aes(time, value, group=variable, colour=variable)) + theme_bw()
	p <- p + geom_line(data = df, alpha = 0.5)
	p <- p + geom_line(data = df2)
	p <- p + opts(legend.position="none")
	p <- p + labs(x = "\nTime into experiment (Seconds)", y = "Utime per process\n")
	p <- p + xlim(minX, maxX)
	p
	
	ggsave(file="utimes.png", width=8, height=6, dpi=100)
}

if(file.exists("stimes.txt")){
	df <- read.table("stimes.txt", header = TRUE, check.names = FALSE)
	df <- melt(df, id="time")
	
	df2 <- read.table("stimes_node.txt", header = TRUE, check.names = FALSE)
	df2 <- melt(df2, id="time")
	
	p <- ggplot(df, aes(time, value, group=variable, colour=variable)) + theme_bw()
	p <- p + geom_line(data = df, alpha = 0.5)
	p <- p + geom_line(data = df2)
	p <- p + opts(legend.position="none")
	p <- p + labs(x = "\nTime into experiment (Seconds)", y = "Stime per process\n")
	p <- p + xlim(minX, maxX)
	p
	
	ggsave(file="stimes.png", width=8, height=6, dpi=100)
}

if(file.exists("wchars.txt")){
	df <- read.table("wchars.txt", header = TRUE, check.names = FALSE)
	df <- melt(df, id="time")
	
	df2 <- read.table("wchars_node.txt", header = TRUE, check.names = FALSE)
	df2 <- melt(df2, id="time")
	
	p <- ggplot(df, aes(time, value, group=variable, colour=variable)) + theme_bw()
	p <- p + geom_line(data = df, alpha = 0.5)
	p <- p + geom_line(data = df2)
	p <- p + opts(legend.position="none")
	p <- p + labs(x = "\nTime into experiment (Seconds)", y = "WChar per process (KiBytes/s)\n")
	p <- p + xlim(minX, maxX)
	p
	
	ggsave(file="wchars.png", width=8, height=6, dpi=100)
}

if(file.exists("rchars.txt")){
	df <- read.table("rchars.txt", header = TRUE, check.names = FALSE)
	df <- melt(df, id="time")
	
	df2 <- read.table("rchars_node.txt", header = TRUE, check.names = FALSE)
	df2 <- melt(df2, id="time")
	
	p <- ggplot(df, aes(time, value, group=variable, colour=variable)) + theme_bw()
	p <- p + geom_line(data = df, alpha = 0.5)
	p <- p + geom_line(data = df2)
	p <- p + opts(legend.position="none")
	p <- p + labs(x = "\nTime into experiment (Seconds)", y = "RChar per process (KiBytes/s)\n")
	p <- p + xlim(minX, maxX)
	p
	
	ggsave(file="rchars.png", width=8, height=6, dpi=100)
}

if(file.exists("vsizes.txt")){
	df <- read.table("vsizes.txt", header = TRUE, check.names = FALSE)
	df <- melt(df, id="time")
	
	df2 <- read.table("vsizes_node.txt", header = TRUE, check.names = FALSE)
	df2 <- melt(df2, id="time")
	
	p <- ggplot(df, aes(time, value, group=variable, colour=variable)) + theme_bw()
	p <- p + geom_step(data = df, alpha = 0.5)
	p <- p + geom_step(data = df2)
	p <- p + opts(legend.position="none")
	p <- p + labs(x = "\nTime into experiment (Seconds)", y = "VSize per process (KiBytes)\n")
	p <- p + xlim(minX, maxX)
	p
	
	ggsave(file="vsizes.png", width=8, height=6, dpi=100)
}