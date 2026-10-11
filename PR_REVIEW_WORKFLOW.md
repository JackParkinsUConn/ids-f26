# Reviewing pull requests in `ids-f26`

Use this checklist to review one contribution at a time. The project is a
student-contributed supplement to `ids-book`; review for correctness and
clarity while preserving the student's authorship. Give specific feedback and
separate required fixes from suggestions.

## 1. Check the repository and list open PRs

Start from the `ids-f26` repository:

```sh
cd /path/to/ids-f26
git status --short
```

Git does not have a pull-request concept, so plain Git cannot list PRs. For a
GitHub-hosted repository, list them with GitHub CLI:

```sh
gh pr list --state open
gh pr view 42
```

Replace `42` with the PR number shown by the list. For another hosting
service, use its PR/MR interface or CLI.

## 2. Check out and inspect one contribution

With GitHub CLI:

```sh
gh pr checkout 42
```

With plain Git, first identify the branch name from the PR page, then fetch and
check it out. Remote branches can be listed, but Git cannot tell which ones
are PRs:

```sh
git fetch origin
git branch -r
git switch --track origin/<branch-name>
```

Inspect the changes against the target branch:

```sh
git diff origin/main...HEAD --stat
git diff origin/main...HEAD
git diff --check
```

Check technical correctness, clarity, reproducibility, attribution, file
organization, generated files, and accidental or sensitive data. Confirm that
the contribution adds student-created explanations, examples, or extensions
rather than duplicating substantial instructor-authored exposition.

## 3. Render when useful

Activate the course Python environment (Python 3.12) before rendering. Set
`ENVIRONMENT_DIRECTORY` to the existing environment's directory:

```sh
ENVIRONMENT_DIRECTORY=/path/to/ids-book/.ids
source "$ENVIRONMENT_DIRECTORY/bin/activate"
```

Render one changed presentation while reviewing it:

```sh
make render-one FILE=topic/<presentation>/index.qmd
```

Render the complete site when the change affects navigation, shared settings,
or multiple pages:

```sh
make render
```

## 4. Send review feedback

Use the hosting service's review interface. For GitHub, GitHub CLI can submit
a comment, request changes, or approve. Put detailed feedback in `review.md`:

```sh
gh pr review 42 --comment --body-file review.md
gh pr review 42 --request-changes --body-file review.md
gh pr review 42 --approve
```

Choose the review action that matches the result. Include concrete file and
line references, explain why a change is needed, and distinguish required
corrections from optional suggestions. A contribution does not have to be
merged to receive credit; editorial acceptance and grading are separate.

## 5. Decide whether to merge, then clean up

After the author updates the PR, inspect the new diff and rerun relevant
checks. If you want revisions before deciding, submit **Request changes** and
leave the PR open. If you decide not to accept the contribution, leave a brief
explanation and close the PR without merging. On GitHub, use **Close pull
request** on the PR page.

If you decide to merge, do so through the PR page or GitHub CLI:

```sh
gh pr merge 42 --squash
```

When you are done reviewing, return to `main` and remove the exact local PR
checkout branch. This applies whether the PR was merged or closed without
merging. For example, if `gh pr checkout 45` created `topic/ong-pandas`:

```sh
git switch main
git branch -d topic/ong-pandas
git status --short
```

A PR closed without merging will normally make Git report that the branch is
not fully merged. If you have confirmed the branch contains no local work you
need, force-delete that local review branch with `git branch -D <branch-name>`.
A squash merge can produce the same warning. Never substitute the base branch
`main` for the PR checkout name. Deleting this local branch does not delete the
contributor's branch on GitHub.

The PR source branch may live in a contributor fork. Delete it through the
hosting service only if you have permission; otherwise leave it for the author.
Use `git push origin --delete <branch-name>` only for a source branch that
belongs to the `origin` repository.
