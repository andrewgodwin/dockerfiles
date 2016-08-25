docker-base
===========

Base image for all my other docker images. Key features:

* Runs multiple commands, and will exit when any do
* Cleans up zombie processes
* Will run /etc/rc.local if it exists
* SSH host key checking disabled for outbound connections
* Unprivileged "user" account to drop permissions to if required


Configuring CMD
---------------

docker-base uses the ``CMD`` stanza in a Dockerfile non-traditionally;
it will only work with a list (exec)-form line, and it will run each entry
as a separate process. For example::

    CMD = ["nginx", "gunicorn myapp.wsgi:application"]

If any of the processes exits, then the whole container will quit (I like
things that fail hard).


Philosophy
----------

While I agree with baseimage-docker that a container should run multiple
processes fine (you're containerising logical components, not single processes),
I don't agree with having things like syslog, cron and SSH running in there.

This base image forces you to be explicit - there's no way for a ancestor image
to define running services you don't know about, and if one thing dies it'll
all go down (after all, you should be using Docker's restart functionality,
not relying on something like supervisord to restart invidivual pieces inside
a container).
