import React from 'react';
import { useTranslation } from 'react-i18next';

const DashboardPage: React.FC = () => {
  const { t } = useTranslation();
  return (
    <div className="flex flex-col items-center justify-center min-h-screen bg-gray-50">
      <div className="bg-white p-8 rounded shadow-md w-96 text-center">
        <h1 className="text-2xl mb-4">{t('dashboard.title')}</h1>
        <div className="mb-2">🕒 {new Date().toLocaleTimeString()}</div>
        <div className="mb-2">📅 {new Date().toLocaleDateString()}</div>
      </div>
    </div>
  );
};

export default DashboardPage;
