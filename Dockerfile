FROM mafermedia/kvik-r

RUN apt-get update  && \
    apt-get install -y default-jre \
    default-jdk \
    libmariadb-dev \
    libmagick++-dev
    
# Install R package dependencies 
RUN R -e 'install.packages(c("ggplot2", "Hmisc", "Rcpp", "roxygen2", "jsonlite", "igraph", "dplyr", "parallel", "colorspace", "ic10", "igraph", "network","GGally","sna", "animation", "devtools", "WGCNA", "BiocManager"), repos="http://cran.rstudio.com")'
RUN R -e 'BiocManager::install(c("genefu", "impute", "preprocessCore", "GO.db", "illuminaHumanv4.db", "illuminaHumanv3.db","hgu133a.db", "breastCancerVDX"))'
RUN R -e 'install.packages("WGCNA")'

RUN R -e 'devtools::install_github("vdumeaux/mixtR")'

ADD . /mixtApp
RUN R CMD INSTALL /mixtApp

WORKDIR /go/src/github.com/fjukstad/kvik/r/examples
