#------------------------------------------------------------------------------
# Copyright 2019 Robert Cowart
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#------------------------------------------------------------------------------

FROM telegraf:1.12.4-alpine

ARG BUILD_DATE

LABEL org.opencontainers.image.created="$BUILD_DATE" \
      org.opencontainers.image.authors="elastiflow@gmail.com" \
      org.opencontainers.image.url="https://hub.docker.com/r/robcowart/influxdb_ha_kafka" \
      org.opencontainers.image.documentation="https://github.com/robcowart/influxdb_ha_kafka/README.md" \
      org.opencontainers.image.source="https://github.com/robcowart/influxdb_ha_kafka" \
      org.opencontainers.image.version="listener1_0.0.3" \
      org.opencontainers.image.vendor="Robert Cowart" \
      org.opencontainers.image.title="influxdb-ha-kafka" \
      org.opencontainers.image.description="Telegraf containers which leverage Kafka to replicate data between multiple InfluxDB instances." \
      org.opencontainers.image.licenses="Apache-2.0"

WORKDIR /etc/telegraf
COPY ./assets/telegraf.conf ./

WORKDIR /etc/telegraf/telegraf.d
COPY ./assets/telegraf.d.listener1/input_influxdb_listener.toml.conf ./
COPY ./assets/telegraf.d/output_kafka.toml.conf ./
COPY ./assets/telegraf.d/processor_20_strings.toml.conf ./

ENTRYPOINT ["/entrypoint.sh"]
CMD telegraf --config /etc/telegraf/telegraf.conf --config-directory /etc/telegraf/telegraf.d
