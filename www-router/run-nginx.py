#!/usr/bin/python3

import os

sites = {}

# Find all sites we should serve and their backends
for key, value in os.environ.items():
    if "." in key:
        # See if they want a redirect instead
        if value.startswith("redirect:"):
            sites[key.rstrip(".")] = {"redirect": value[9:]}
        else:
            sites[key.rstrip(".")] = {"backend": value}

# Write custom nginx site config
with open("/etc/nginx/sites.conf", "w") as fh:
    for domain, config in sites.items():
        if "redirect" in config:
            fh.write("""
                server {{
                    listen 80;
                    server_name {domain};
                    rewrite ^(.*)$ http://{redirect}$1 redirect;
                }}
            """.format(domain=domain, **config))
        else:
            fh.write("""
                server {{
                    listen 80;
                    server_name {domain};
                    location / {{
                        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                        proxy_set_header Host $http_host;
                        proxy_redirect off;
                        proxy_pass http://{backend};
                        proxy_max_temp_file_size 0;
                    }}
                }}
            """.format(domain=domain, **config))

# Launch into nginx
os.execv("/usr/sbin/nginx", ["/usr/sbin/nginx"])
