# Backend Testing Guide

## Unit Testing
- Uses **pytest** for all backend tests
- All test files are in the `tests/` directory

## Running Tests
- Run all tests:
  ```bash
  ./run_all_tests.sh
  ```
- Run a specific module:
  ```bash
  ./run_test.sh tests/test_auth.py
  ```

## Coverage
- Coverage is reported via `pytest-cov`
- Minimum 80% coverage recommended

## Notes
- Use fixtures in `conftest.py` for setup/teardown
- Add new test files for new modules
