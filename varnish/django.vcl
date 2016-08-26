vcl 4.0;

include "backend.vcl";

sub vcl_recv {

  include "extra-recv.vcl";

  # /static and /media files never cached
  if (req.url ~ "^/static" || req.url ~ "^/media") {
    return (pipe);
  }

  # Websocket support
  if (req.http.Upgrade ~ "(?i)websocket") {
     return (pipe);
  }

  # Only vary on the sessionid or csrftoken cookies
  if (req.method == "GET" && (req.url ~ "^/static" || (req.http.cookie !~ "sessionid" && req.http.cookie !~ "csrftoken" && req.http.cookie !~ "AUTHENTICATION"))) {
    unset req.http.Cookie;
  }

  # Normalize accept-encoding to account for different browsers
  if (req.http.Accept-Encoding) {
    if (req.url ~ "\.(jpg|png|gif|gz|tgz|bz2|tbz|mp3|ogg)$") {
        # No point in compressing these
        unset req.http.Accept-Encoding;
    } elsif (req.http.Accept-Encoding ~ "gzip") {
        set req.http.Accept-Encoding = "gzip";
    } elsif (req.http.Accept-Encoding ~ "deflate") {
        set req.http.Accept-Encoding = "deflate";
    } else {
        # unknown algorithm
        unset req.http.Accept-Encoding;
    }
  }

}


sub vcl_backend_response {

  # Set custom VCL header
  set beresp.http.X-Varnish-Backend = beresp.backend.name;

  # pass through for anything with a session/csrftoken set
  if (beresp.http.set-cookie ~ "sessionid" || beresp.http.set-cookie ~ "csrftoken" || beresp.http.set-cookie ~ "AUTHENTICATION") {
    set beresp.uncacheable = true;
    set beresp.ttl = 120s;
  }
  return (deliver);

}
