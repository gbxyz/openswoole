# Docker Image for Openswoole

![CI](https://github.com/gbxyz/openswoole/actions/workflows/ci.yaml/badge.svg)

Ubuntu + PHP + [Openswoole](https://openswoole.com/). This isn't very useful on its own, it's a base image for other things.

A couple of different versions of Ubuntu, and of PHP, are [supported](https://hub.docker.com/r/gbxyz/openswoole/tags).

Images are available for both amd64 and arm64.

## Note on memcache/memcached support

This image shipped with the [memcache](https://www.php.net/manual/en/book.memcache.php)
extension for PHP versions <= 8.4. From 8.5 onwards, the [memcached](https://www.php.net/manual/en/book.memcached.php)
extension is shipped instead.
