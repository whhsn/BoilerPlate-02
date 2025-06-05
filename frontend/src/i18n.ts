import i18n from 'i18next';
import { initReactI18next } from 'react-i18next';

const resources = {
  en: {
    translation: {
      login: {
        title: 'Login',
        username: 'Username',
        password: 'Password',
        submit: 'Login',
        forgot: 'Forgot Password?',
        error: 'Invalid username or password',
      },
      dashboard: {
        title: 'Dashboard',
      },
    },
  },
  ar: {
    translation: {
      login: {
        title: 'تسجيل الدخول',
        username: 'اسم المستخدم',
        password: 'كلمة المرور',
        submit: 'دخول',
        forgot: 'نسيت كلمة المرور؟',
        error: 'اسم المستخدم أو كلمة المرور غير صحيحة',
      },
      dashboard: {
        title: 'لوحة التحكم',
      },
    },
  },
};

i18n.use(initReactI18next).init({
  resources,
  lng: 'ar',
  fallbackLng: 'en',
  interpolation: { escapeValue: false },
});

export default i18n;
