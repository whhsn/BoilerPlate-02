import axios from 'axios';

export const api = axios.create({
  baseURL: '/api',
  withCredentials: true,
});

export async function login(username: string, password: string) {
  const { data } = await api.post('/auth/login', { username, password });
  return data.user;
}

export async function logout() {
  await api.post('/auth/logout');
}

export async function getUser() {
  const { data } = await api.get('/auth/me');
  return data.user;
}
