#!/bin/bash
exec hhvm --mode server -d hhvm.server.type=fastcgi -d hhvm.server.port=9000 -d hhvm.server.source_root=/app/
