import axios from 'axios';
import logger from './logger';

export const api = axios.create({
  baseURL: '/api',
  withCredentials: true,
});

// Request logging
api.interceptors.request.use((config) => {
  // Deep clone the config to avoid circular reference issues in logging
  const logConfig = {
    url: config.url,
    method: config.method,
    baseURL: config.baseURL,
    headers: config.headers,
    data: config.data,
    withCredentials: config.withCredentials
  };
  
  logger.debug('🚀 Request:', logConfig);
  return config;
}, (error) => {
  logger.error('❌ Request Error:', {
    message: error.message,
    config: error.config,
    stack: error.stack
  });
  return Promise.reject(error);
});

// Response logging
api.interceptors.response.use((response) => {
  logger.info('✅ Response:', {
    url: response.config.url,
    status: response.status,
    statusText: response.statusText,
    headers: response.headers,
    data: response.data
  });
  return response;
}, (error) => {
  logger.error('❌ Response Error:', {
    url: error.config?.url,
    status: error.response?.status,
    statusText: error.response?.statusText,
    headers: error.response?.headers,
    data: error.response?.data,
    message: error.message,
    stack: error.stack
  });
  if (error.response?.status === 401) {
    window.location.href = '/login';
  }
  return Promise.reject(error);
});

// Add CSRF token to requests
api.interceptors.request.use((config) => {
  const token = document.cookie
    .split('; ')
    .find(row => row.startsWith('csrf_token='))
    ?.split('=')[1];

  if (token) {
    config.headers['X-CSRF-TOKEN'] = token;
    logger.debug('🔒 Added CSRF token to request');
  } else {
    logger.warn('⚠️ No CSRF token found in cookies');
  }

  config.headers['Content-Type'] = 'application/json';
  return config;
});

export async function login(username: string, password: string) {
  logger.debug('🔑 Attempting login:', { username });
  try {
    const { data } = await api.post('/auth/login', { username, password });
    logger.info('✅ Login successful:', { username });
    return data.user;
  } catch (error) {
    logger.error('❌ Login failed:', { 
      username, 
      error: error.response?.data || error.message
    });
    throw error;
  }
}

export async function logout() {
  logger.debug('🚪 Attempting logout');
  try {
    await api.post('/auth/logout');
    logger.info('✅ Logout successful');
  } catch (error) {
    logger.error('❌ Logout failed:', {
      error: error.response?.data || error.message
    });
    throw error;
  }
}

export async function getUser() {
  logger.debug('👤 Fetching user info');
  try {
    const { data } = await api.get('/auth/me');
    logger.info('✅ User info retrieved:', { user: data.user });
    return data.user;
  } catch (error) {
    logger.error('❌ Failed to fetch user:', {
      error: error.response?.data || error.message
    });
    throw error;
  }
}
