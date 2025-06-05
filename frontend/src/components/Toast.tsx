import React from 'react';

interface ToastProps {
  message: string;
  type?: 'success' | 'error' | 'info';
}

const Toast: React.FC<ToastProps> = ({ message, type = 'info' }) => {
  const color = type === 'error' ? 'bg-red-500' : type === 'success' ? 'bg-green-500' : 'bg-blue-500';
  return (
    <div className={`fixed top-4 right-4 z-50 px-4 py-2 text-white rounded shadow-lg ${color}`}>
      {message}
    </div>
  );
};

export default Toast;
