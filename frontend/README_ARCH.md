# Frontend Architecture Overview

## Structure
- **src/**
  - **components/**: Reusable UI components (atoms, molecules, organisms)
  - **pages/**: Route-level components (Login, Dashboard)
  - **context/**: React context providers (Auth)
  - **lib/**: API client and utility functions
  - **i18n.ts**: Localization setup
  - **index.tsx**: App entry point
  - **App.tsx**: Main app and routing
  - **types/**: TypeScript type declarations

## Key Features
- **Vite** for fast builds
- **Tailwind CSS** + **Shadcn UI** for styling
- **RTL & i18n**: Arabic and English support
- **Auth Context**: Global authentication state
- **ProtectedRoute**: Role-based route protection
- **API Client**: Centralized, type-safe axios instance
- **Testing**: Vitest for unit/component tests
- **Linting**: ESLint for code quality

## Extensibility
- Add new pages in `src/pages/`
- Add new API endpoints in `src/lib/api.ts`
- Add new languages in `src/i18n.ts`
