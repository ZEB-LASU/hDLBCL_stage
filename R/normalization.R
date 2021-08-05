# Copyright (C) 2021  Abdulazeez Giwa <abdulazeez.giwa@lasu.edu.ng>
#		      Azeez Fatai <azeez.fatai@lasu.edu.ng>
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
beta <- read.csv("~/Methyl_imputed.csv", row.names=1)
pd <- read.csv("~/pd.csv", row.names=1) 
pd$Sample_Group <- as.factor(pd$Sample_Group)
myNorm <- champ.norm(beta = data.matrix(beta))
write.csv(myNorm, "~/Methyl_norm.csv")
