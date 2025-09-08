// Patched to allow env-configurable Fluentd host/port (HW26)
const winston = require('winston');
const fluentLogger = require('fluent-logger');

const FLUENTD_HOST = process.env.FLUENTD_HOST || 'fluentd';
const FLUENTD_PORT = parseInt(process.env.FLUENTD_PORT || '24224', 10);

const fluentTransport = fluentLogger.createFluentSender('js_app', {
  host: FLUENTD_HOST,
  port: FLUENTD_PORT,
  timeout: 3.0
});

const logger = winston.createLogger({
  level: 'info',
  transports: [new winston.transports.Console()]
});

logger.on('data', (log) => {
  fluentTransport.emit('winston', {
    level: log.level,
    message: log.message,
    meta: log.meta || {},
    timestamp: new Date().toISOString()
  });
});

module.exports = logger;
