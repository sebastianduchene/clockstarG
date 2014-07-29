dat_lines <- readLines("all_concat_format.phy")

dat_lines[30:length(dat_lines)] <- gsub("New|Sor|Gor|Oto|Spe|Ory|Dip|Tur|Mic|Eri|Och|Lox|Fel|Tar|Pro|Ech|Das|Mus|Rat|Cav|Cho|Bos|Cal|Pon|Hom|Pan|Sus|Vic|Can|", "", dat_lines[30:length(dat_lines)])



cat(dat_lines, file = "all_concat_2.phy", sep = "\n")

