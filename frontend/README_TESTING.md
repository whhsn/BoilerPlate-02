# Frontend Testing Guide

## Unit & Component Testing
- Uses **Vitest** for all tests
- All test files should be placed next to the component/page under `__tests__/` or with `.test.tsx`/`.test.ts` suffix

## Running Tests
- Run all tests:
  ```bash
  npm run test:unit
  ```
- Run with coverage:
  ```bash
  npm run test:coverage
  ```

## Coverage
- Minimum 80% coverage enforced in `vitest.config.ts`
- Coverage reports output to `coverage/` directory

## Linting
- Run ESLint:
  ```bash
  npm run lint
  ```
