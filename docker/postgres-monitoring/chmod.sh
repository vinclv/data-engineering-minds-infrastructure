#!/bin/bash
chmod 400 /opt/bitnami/postgres-exporter/conf/pass
exec "$@"