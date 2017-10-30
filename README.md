# BasicRailsApp

## Setup

### Install requirements

- PostgreSQL 9.6
- ruby from `.ruby-version`
- [NodeJS](https://nodejs.org/en/download/package-manager/)
- [Yarn](https://yarnpkg.com/en/docs/install)
- `gifsicle`, `optipng`, `jpegoptim` to optimize images while `assets:precompile`.

### App

- Clone repo.
- _Optionally._ `bin/copy_samples` and edit `database.yml`.
- Run `bin/setup`.

## Development

- Follow rubocop advices.
- Write simple code, which is easy to support.
- Prefer TDD:

  - Write request spec for every path from routes.
  - Write additional request specs for branches in templates.
  - Use RSpec helpers and idioms (`its`, `described_class`, `subject { -> {} }`, etc.).

### Assets

Use Yarn for external js libs. Provide yarn on app server as it fetches dependencies
on `assets:precompile`.
