http-feedproxy
==============

This tool sets up a local HTTP server that delivers static Atom feeds.

More precisely, when configured as a proxy, it simulates virtual hosts that
serve feeds. 

Remarks, feature requests and bug reports are appreciated, contact me on
[github](https://github.com/emillon/http-feedproxy) !

Usage
-----

`http-feedproxy conf.json`. An example configuration file is available in the
repository.

A wrapper script is also available to run a program within a virtual
environment : `with-feedproxy conf.json program args`.

Dependencies
------------

  - A Haskell compiler (tested with GHC)
  - Haskell libraries listed in `http-feedproxy.cabal`
