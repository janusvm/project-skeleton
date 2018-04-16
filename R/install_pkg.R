if (!require("devtools")) {
  install.packages("devtools")
  library("devtools")
}

install("R/<R_PKG>/", dependencies = TRUE)
