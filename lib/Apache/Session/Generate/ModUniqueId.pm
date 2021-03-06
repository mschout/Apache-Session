package Apache::Session::Generate::ModUniqueId;

use strict;
use vars qw($VERSION);
$VERSION = '0.02';

sub generate {
    my $session = shift;
    unless (exists $ENV{UNIQUE_ID}) {
	require Carp;
	Carp::croak('Can\'t get UNIQUE_ID env variable. Make sure mod_unique_id is enabled.');
    }
    $session->{data}->{_session_id} = $ENV{UNIQUE_ID};
}

sub validate {
    my $session = shift;
    $session->{data}->{_session_id} =~ /^[A-Za-z0-9@\-]+$/
	or die "invalid session id: $session->{data}->{_session_id}.";
}

1;
__END__

=head1 NAME

Apache::Session::Generate::ModUniqueId - mod_unique_id for session ID generation

=head1 SYNOPSIS

  use Apache::Session::Flex;

  tie %session, 'Apache::Session::Flex', $id, {
       Store     => 'MySQL',
       Lock      => 'Null',
       Generate  => 'ModUniqueId',
       Serialize => 'Storable',
  };

=head1 DESCRIPTION

Apache::Session::Generate::ModUniqueId enables you to use unique id
generated by mod_unique_id as session id for Apache::Session
framework. Using mod_unique_id would ensure higher level uniquess of
id.

=head1 AUTHOR

Tatsuhiko Miyagawa <miyagawa@bulknews.net>

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

L<Apache::Session>, L<Apache::Session::Flex>, mod_unique_id

=cut
