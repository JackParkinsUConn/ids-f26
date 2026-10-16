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

## Current local state (2026-10-16)

The checkout is on `main` at `55a295f`, one commit ahead of the local
`origin/main` tracking ref. This count was checked without fetching GitHub.
The tracked worktree was clean before this handoff update. The only local
branches are `main` and `gh-pages`; earlier review branches are gone. Use
`gh pr list --state open` and `gh pr view <number>` for current GitHub PR
information. A Git fetch alone cannot list pull requests.

Untracked local material remains, including `.ids`, midterm drafts, instructor
solutions, data documentation, and generated figure directories. Preserve these
files and do not stage them during routine maintenance. The instructor has
deferred further midterm work. Graded submissions belong in Classroom 50.

The linked `ids-f26` path inside the book checkout is an untracked,
machine-specific symlink. Clone this repository separately on the other
computer; do not expect that link or a Python environment to transfer.

## Rendering and review

Use the same Python 3.12 environment as `ids-book` and coursework. Follow
the current README for setup; do not create another environment here. The
Makefile expects the shared environment to be active and does not create
one. Install or refresh dependencies by running `make install` from the
book checkout with that environment active.

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

## Latest session update (2026-10-16)

The single source for dependencies is now `ids-book/requirements.txt`,
including `python-dotenv` for the Census presentation. The semester file
contains `-r ../ids-book/requirements.txt` and assumes side-by-side checkouts.
For other layouts, install from the actual book directory. Use one shared
environment and propose new dependencies in the book repository for
instructor approval. The setup and contribution documentation reflect this
policy. The local semester checkout is nested, so use `make install` from
`/home/junyan/work/teaching/ids-book` to refresh this machine's environment.

### Accepted presentations and contributor credit

Amanda Noe's Census presentation was merged in `df241f5` (PR #36). Commit
`46fd421` links it from `chapters/data-acquisition.qmd`, adds Amanda Noe and
Enrico Ong to the book's author metadata, and identifies Enrico beside his
pandas presentation link. Student contributions belong in these collaborative
notes, with catalog entries in the appropriate `chapters/` file. Credit each
accepted presentation's authors in its catalog entry and update the book
metadata as contributors are added.

### Completed dependency cleanup

Commit `55a295f` replaces the duplicate dependency pins with the book include
and updates the README, introduction, contribution guide, review workflow,
Codex instructions, and this handoff. The corresponding book commit is
`d288fb2`, which adds `python-dotenv` and documents the shared environment.
Neither dependency commit was pushed in this session.

Diff checks passed. This cleanup did not install packages or render the site.
The Census presentation rendered successfully during the earlier PR review;
that result predates the contributor's later merged revisions. Use the shared
environment for the next render. This handoff update is not itself committed.
