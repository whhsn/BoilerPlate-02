import { render, screen, fireEvent } from '@testing-library/react';
import { AuthProvider } from '../../context/AuthContext';
import LoginPage from '../LoginPage';
import '../../i18n';

describe('LoginPage', () => {
  it('renders login form', () => {
    render(
      <AuthProvider>
        <LoginPage />
      </AuthProvider>
    );
    expect(screen.getByLabelText(/username/i)).toBeInTheDocument();
    expect(screen.getByLabelText(/password/i)).toBeInTheDocument();
    expect(screen.getByRole('button')).toBeInTheDocument();
  });
});
