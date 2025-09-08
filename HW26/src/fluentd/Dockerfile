FROM fluent/fluentd:v1.16-debian-1
USER root

# Прибираємо все зайве та ставимо стек ES 7.x + Faraday Excon + плагін
RUN gem uninstall -aIx elasticsearch elasticsearch-api elasticsearch-transport elastic-transport fluent-plugin-elasticsearch || true \
 && gem install elasticsearch-transport -v "~> 7.17" \
 && gem install elasticsearch-api       -v "~> 7.17" \
 && gem install elasticsearch           -v "~> 7.17" \
 && gem install faraday-excon           -v "~> 2.3" \
 && gem install fluent-plugin-elasticsearch -v "5.2.3"

# Підвантажити адаптер Excon для Faraday під час старту
ENV RUBYOPT="-rfaraday/excon"

COPY fluent.conf /fluentd/etc/fluent.conf
USER fluent
