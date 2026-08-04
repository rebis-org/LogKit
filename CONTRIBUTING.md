# Contributing

## Code of Conduct

Participation is governed by the [Code of Conduct](./CODE_OF_CONDUCT.md). By contributing, you agree to uphold it.

## Before opening a pull request

Outside contributors must open an issue and receive acknowledgment before opening a PR.

1. Search existing issues.
2. Open an issue using the appropriate template.
3. Await triage. A maintainer will label it and confirm direction. Trivial fixes may be waived at a maintainer's discretion.
4. Claim the issue, then open a PR that references it with `Closes #<issue>`.

Organization members may open PRs directly for small changes; linking an issue is still preferred.

## Labels

Issues are labeled `kind/*` and `status/*`; maintainers update `status/*` during triage.

## Development setup

```bash
git clone https://github.com/rebis-org/LogKit.git
cd LogKit
swift build
```

## Conventions

- Warnings are errors. Changes must build cleanly.
- Match surrounding style, including doc comments on public API.
- Prefer additive, non-breaking changes. Breaking changes must be labeled `breaking` and stated explicitly.
- Commit messages follow [Conventional Commits][conventional].

## Opening a pull request

1. Branch from `main` and keep it up to date.
2. Complete the pull request template.
3. Keep the PR focused; split unrelated changes into separate PRs.

## Licensing

By contributing, you agree that your contributions are licensed under the project license and that you have the right to submit them.

[conventional]: https://www.conventionalcommits.org/en/v1.0.0/
