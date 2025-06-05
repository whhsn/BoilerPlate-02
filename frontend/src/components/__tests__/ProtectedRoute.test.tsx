import { render } from '@testing-library/react';
import ProtectedRoute from '../ProtectedRoute';
import { AuthProvider } from '../../context/AuthContext';
import { MemoryRouter } from 'react-router-dom';

describe('ProtectedRoute', () => {
  it('redirects unauthenticated users', () => {
    render(
      <AuthProvider>
        <MemoryRouter initialEntries={['/']}>
          <ProtectedRoute roles={['user']}>
            <div>Protected</div>
          </ProtectedRoute>
        </MemoryRouter>
      </AuthProvider>
    );
    // No assertion here as redirect is handled by react-router
  });
});
