# Fall 2026 student notes handoff

This is a dated snapshot for continuing work in a new checkout. Check the live
branch, worktree, and pull requests before acting. Read `codex.md`, `README.md`,
`CONTRIBUTING.md`, and `PR_REVIEW_WORKFLOW.md` for the repository's standing
instructions.

## Project boundaries

`ids-f26` is the Fall 2026 student-contributed Quarto notes site. The
instructor-authored, semester-independent book lives in the separate
`statds/ids-book` repository. Topic presentations live under `topic/`, final
presentations under `final/`, and catalog entries under `chapters/`. Preserve
student authorship during review and keep private graded work out of this repo.

## Current local state (2026-10-12)

The checkout is clean on `main` at `0be979e`, matching its local
`origin/main` tracking ref. The local branches
`topic/amanda-noe-census-data` and `topic/horan-elizabeth-geopandas` remain
from reviews; their current pull-request states were not checked for this
handoff. Use `gh pr list --state open` and `gh pr view <number>` for current
GitHub PR information. A Git fetch alone cannot list pull requests.

The linked `ids-f26` path inside the book checkout is an untracked,
machine-specific symlink. Clone this repository separately on the other
computer; do not expect that link or a Python environment to transfer.

## Rendering and review

Use Python 3.12 and an environment with `requirements.txt` installed. The
Makefile expects the environment to be active and does not create one. A new
checkout can set one up with:

```sh
python3.12 -m venv .ids
source .ids/bin/activate
python -m pip install -r requirements.txt
```

Render a changed presentation with
`make render-one FILE=topic/<name>/index.qmd`; run `make render` when the
site or multiple presentations need checking. Generated Quarto files and the
`.ids` environment are ignored. Each presentation may keep its own
`references.bib` beside `index.qmd`; use a relative bibliography path that
resolves from that presentation. The instructor's book environment has also
been used to render this repository on the original computer.

For PR review, follow `PR_REVIEW_WORKFLOW.md`: inspect the diff against
`origin/main`, give specific feedback, allow the contributor to revise, and
merge only when satisfied. Return to `main` and remove a local review branch
when finished. Deleting a local branch does not delete a contributor's branch
on GitHub. The workflow document also explains how to close a PR without
merging and how to request changes.

## Recent decisions

The November 2 class cancellation is recorded in the schedule as a trade for
midterm-project work during the week of October 18. PR #46 was merged and is
part of `main`. Review current GitHub state before drawing conclusions about
any other PR. The instructor plans to revisit whether classification should
be a separate chapter in `ids-book`; no `ids-f26` restructure is needed for
that discussion.
