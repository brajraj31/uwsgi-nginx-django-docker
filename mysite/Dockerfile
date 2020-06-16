FROM python:3.6-alpine
ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1
ENV USER docker
ENV DIR /home 
#RUN groupadd --gid 5000 $USER && useradd -m --uid 5000 --gid 5000 $USER
USER root
RUN apk add --update \
    nginx \
    supervisor \ 
    python3-dev \
    build-base \
    linux-headers \
    pcre-dev \
    py-pip \ 
    vim \
  && rm -rf /var/cache/apk/* && \
  chown -R nginx:www-data /var/lib/nginx 

# setup all the configfiles
COPY /nginx/nginx.conf /etc/nginx/nginx.conf
COPY /nginx/nginx-app.conf /etc/nginx/sites-available/default
COPY /supervisord/supervisor-app.conf /etc/supervisor/conf.d/supervisor-app.conf

RUN cat /etc/supervisor/conf.d/supervisor-app.conf

RUN mkdir -p home/docker/code
WORKDIR  /home/docker/code/
#COPY requirements*.txt  ${DIR}/${USER}/code/
#COPY start.sh  ${DIR}/${USER}/code/
RUN pip install --user --upgrade pip
#RUN pip install -r requirements.txt
RUN pip install django
RUN pip install uwsgi
COPY .  /home/docker/code/

RUN chmod 777 -R /home/docker/code/
RUN ls -altr /home/docker/code/
#RUN chown -R $USER:$USER  ${DIR}/${USER}/code/ && chmod 777 -R ${DIR}/${USER}/code/

#RUN mkdir /etc/nginx/sites-enabled
#RUN rm /etc/nginx/nginx.conf
#RUN ln -s /home/docker/code/nginx/nginx.conf /etc/nginx/
#RUN ln -s /home/docker/code/nginx/nginx-app.conf /etc/nginx/sites-enabled/
#RUN rm /etc/supervisord.conf
#RUN ln -s /home/docker/code/supervisord/supervisor-app.conf /etc/
#USER ${USER} 
#STOPSIGNAL SIGTERM
EXPOSE 8800
CMD ["supervisord", "-n", "-c", "/etc/supervisor/conf.d/supervisor-app.conf"]
#ENTRYPOINT ["/home/docker/code/start.sh"]   # add the script file as entrypointhome
#CMD ["/home/docker/code/start.sh"]
