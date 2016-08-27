cron
====

Container that runs cron jobs.

You can supply entries by passing environment variables to the
container where the name start with ``job`` and the value is the crontab line::

    environment:
        job-dump: @hourly pg_dump aeracode /srv/backups/aeracode.psql
        job1: */10 * * * * curl http://someurl.com/thing/
        PGUSER: postgres
        PGPASSWORD: abcdef
        PGHOST: postgres
