include "backend.vcl";

sub vcl_recv {

  include "extra-recv.vcl";

}
