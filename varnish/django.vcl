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
  if (req.request == "GET" && (req.url ~ "^/static" || (req.http.cookie !~ "sessionid" && req.http.cookie !~ "csrftoken" && req.http.cookie !~ "AUTHENTICATION"))) {
    remove req.http.Cookie;
  }

  # Normalize accept-encoding to account for different browsers
  if (req.http.Accept-Encoding) {
    if (req.url ~ "\.(jpg|png|gif|gz|tgz|bz2|tbz|mp3|ogg)$") {
        # No point in compressing these
        remove req.http.Accept-Encoding;
    } elsif (req.http.Accept-Encoding ~ "gzip") {
        set req.http.Accept-Encoding = "gzip";
    } elsif (req.http.Accept-Encoding ~ "deflate") {
        set req.http.Accept-Encoding = "deflate";
    } else {
        # unknown algorithm
        remove req.http.Accept-Encoding;
    }
  }

}


sub vcl_fetch {

  # Set custom VCL header
  set beresp.http.X-Varnish-Backend = beresp.backend.name;

  # pass through for anything with a session/csrftoken set
  if (beresp.http.set-cookie ~ "sessionid" || beresp.http.set-cookie ~ "csrftoken" || beresp.http.set-cookie ~ "AUTHENTICATION") {
    return (hit_for_pass);
  } else {
    return (deliver);
  }

}
