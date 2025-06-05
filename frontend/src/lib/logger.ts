// Centralized logging utility for the frontend
// Easily extendable for production logging, error reporting, or external services

export type LogLevel = 'debug' | 'info' | 'warn' | 'error';

interface Logger {
  debug: (...args: any[]) => void;
  info: (...args: any[]) => void;
  warn: (...args: any[]) => void;
  error: (...args: any[]) => void;
}

const isProd = process.env.NODE_ENV === 'production';

const logger: Logger = {
  debug: (...args) => {
    if (!isProd) console.debug('[DEBUG]', ...args);
    // Extend here for remote debug logging
  },
  info: (...args) => {
    if (!isProd) console.info('[INFO]', ...args);
    // Extend here for remote info logging
  },
  warn: (...args) => {
    console.warn('[WARN]', ...args);
    // Extend here for remote warning logging
  },
  error: (...args) => {
    console.error('[ERROR]', ...args);
    // Extend here for error reporting (e.g., Sentry, LogRocket)
  },
};

export default logger;
