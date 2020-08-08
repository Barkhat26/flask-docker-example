FROM ubuntu:latest

ENV TZ=Europe/Moscow
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update -y
RUN apt-get install -y python3 python3-pip python3-dev build-essential nginx supervisor


RUN mkdir -p \
    /my_test_app/src \
    /my_test_app/etc \
    /my_test_app/certs

COPY ./src /my_test_app/src
COPY ./etc /my_test_app/etc

COPY ./requirements.txt /my_test_app

RUN pip3 install -r /my_test_app/requirements.txt

RUN sed -i 's/^\(\[supervisord\]\)$/\1\nnodaemon=true/' /etc/supervisor/supervisord.conf
RUN ln -s /my_test_app/etc/nginx/conf.d/my_test_app.conf /etc/nginx/sites-enabled/my_test_app.conf

RUN ln -s /my_test_app/etc/supervisor/conf.d/nginx.conf /etc/supervisor/conf.d/nginx.conf
RUN ln -s /my_test_app/etc/supervisor/conf.d/my_test_app.conf /etc/supervisor/conf.d/my_test_app.conf 

WORKDIR /my_test_app

EXPOSE 5000

CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]
