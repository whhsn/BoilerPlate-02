import { api } from '../api';

describe('api client', () => {
  it('should have correct baseURL', () => {
    expect(api.defaults.baseURL).toBe('/api');
  });
});
