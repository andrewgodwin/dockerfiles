simple-www
==========

Simple static HTML hosting, with optional direct SFTP access
for users to upload/download stuff.

Mount the files you want to serve into the container as
/srv/www (or inherit from this container and ``ADD`` them there)
