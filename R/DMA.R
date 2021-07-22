# Copyright (C) 2021  Abdulazeez Giwa <abdulazeez.giwa@lasu.edu.ng>
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>

library(ChAMP)

beta <- read.csv("~/Methyl_norm.csv", header=TRUE, row.names=1)
pd <- read.csv("~/pd.csv", header=TRUE, stringsAsFactors = TRUE)

dmp <- champ.DMP(beta = data.matrix(beta), pheno=pd$Sample_Group, compare.group=c("S4","S1"))
write.csv(dmp, "~/DMPs.csv")

dmr <- champ.DMR(beta = data.matrix(beta), pheno=pd$Sample_Group, cores=1)
write.csv(dmr, "~/DMRs.csv")

