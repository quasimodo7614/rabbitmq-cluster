FROM rabbitmq:3.8
copy start.sh /start.sh
RUN chmod a+x /start.sh

copy cluster.sh /cluster.sh
RUN chmod a+x /cluster.sh

CMD ["sh","-c","/start.sh"]


