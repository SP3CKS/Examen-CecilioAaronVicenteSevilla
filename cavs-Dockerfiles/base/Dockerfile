FROM ubuntu

ARG CONTEXTO1
ARG TZ1
ARG WEB1
ARG IDRSA1

RUN mkdir /root/logs
COPY  ./claves/id_rsa.pub /root/
COPY ./proyectos/${WEB1}

COPY ./dockerfiles/base/start.sh /root

RUN echo ${CONTEXTO1}
RUN echo ${TZ1}
RUN echo ${WEB1}
RUN echo ${IDRSA1}



ENTRYPOINT ["/root/start.sh"]