FROM python:3.10-alpine

RUN apk add --no-cache gcc python3-dev linux-headers musl-dev R
RUN apk add --no-cache make g++
RUN apk add --no-cache zeromq curl openssl zeromq-dev
RUN apk add --no-cache R-dev

RUN R -e "install.packages('pbdZMQ', type = 'source', repos = 'http://cran.us.r-project.org')"

RUN R -e "install.packages(c('IRkernel', 'repr', 'IRdisplay'), repos = 'http://cran.us.r-project.org')"

RUN pip install jupyter

RUN R -e "IRkernel::installspec(name = 'r_lang', displayname = 'R 4.1.1')"


CMD R -e "IRkernel::main()" --args $DOCKERNEL_CONNECTION_FILE
