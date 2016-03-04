RUN apt-get update \
    && apt-get install -y cron \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
