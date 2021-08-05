# Copyright (C) 2021  Abdulazeez Giwa <abdulazeez.giwa@lasu.edu.ng>
#		       Azeez Fatai <azeez.fatai@lasu.edu.ng>
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

#Clustering dendrogram

library(factoextra)
data <- as.matrix(read.csv("~/4CpG.csv", row.names=1))
data <- t(data) 
res.hk <- hkmeans(data, 2)
tiff(file = "~/Figure_3.tiff", width = 3000, height = 2000, res=300)
hkmeans_tree(res.hk, cex=0.7, main="")
dev.off()
