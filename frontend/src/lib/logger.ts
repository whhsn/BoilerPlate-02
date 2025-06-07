// Centralized logging utility for the frontend
export type LogLevel = 'debug' | 'info' | 'warn' | 'error';

interface Logger {
  debug: (...args: any[]) => void;
  info: (...args: any[]) => void;
  warn: (...args: any[]) => void;
  error: (...args: any[]) => void;
}

const isProd = process.env.NODE_ENV === 'production';

const formatMessage = (level: string, ...args: any[]) => {
  const timestamp = new Date().toISOString();
  const prefix = `[${timestamp}] [${level}]`;
  
  if (typeof args[0] === 'string') {
    return [
      `%c${prefix}%c ${args[0]}`,
      'color: gray; font-weight: bold',
      'color: inherit',
      ...args.slice(1)
    ];
  }
  
  return [
    `%c${prefix}`,
    'color: gray; font-weight: bold',
    ...args
  ];
};

const logger: Logger = {
  debug: (...args) => {
    if (!isProd) console.debug(...formatMessage('DEBUG', ...args));
  },
  info: (...args) => {
    if (!isProd) console.info(...formatMessage('INFO', ...args));
  },
  warn: (...args) => {
    console.warn(...formatMessage('WARN', ...args));
  },
  error: (...args) => {
    console.error(...formatMessage('ERROR', ...args));
    // In production, you might want to send errors to a service like Sentry
  },
};

export default logger;
