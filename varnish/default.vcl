vcl 4.0;

include "backend.vcl";

sub vcl_recv {

  include "extra-recv.vcl";

}
