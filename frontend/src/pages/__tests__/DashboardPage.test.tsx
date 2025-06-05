import { render, screen } from '@testing-library/react';
import DashboardPage from '../DashboardPage';
import '../../i18n';

describe('DashboardPage', () => {
  it('renders dashboard title', () => {
    render(<DashboardPage />);
    expect(screen.getByText(/dashboard/i)).toBeInTheDocument();
  });
});
