FROM mysql:5.7

ENV MYSQL_REPLICATION_USER replication
ENV MYSQL_REPLICATION_PASSWORD replication_pass
ENV MYSQL_MASTER_PORT 3306

COPY replication-entrypoint.sh /usr/local/bin/
COPY init-slave.sh /usr/local/bin/

RUN ln -s usr/local/bin/replication-entrypoint.sh /replication-entrypoint.sh \
    && ln -s usr/local/bin/init-slave.sh /init-slave.sh


ENTRYPOINT ["/replication-entrypoint.sh"]

CMD ["mysqld"]
