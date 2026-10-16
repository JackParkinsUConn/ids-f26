# Contributing a Presentation

These notes are a collection of short, student-developed presentations. A
presentation should add something useful to the instructor-authored
[`ids-book`](https://statds.github.io/ids-book/): a worked example, an
alternative explanation, a visualization, a debugging lesson, an application,
or a useful extension. Do not copy a chapter from the book into this
repository. Link to the relevant book section and use the presentation to
show what you discovered or what helped make the idea concrete.

The repository has two presentation collections:

- `topic/` contains presentations that teach one method, concept, workflow, or
  tool. These presentations are linked from the topical chapters.
- `final/` contains presentations about original data-science projects. These
  presentations are linked from the final-project chapter.

## Topic presentations

A topic presentation teaches one focused idea. It is not a record of every
detail discussed in class, and it is not a substitute for the relevant chapter
of the book. A strong presentation gives the audience a reason to care, builds
one clear example, interprets the result, and ends with practical takeaways.

### 1. Choose a focused contribution

Start with a method, concept, or problem that can be explained in a short
RevealJS deck. Useful topics include a data-wrangling operation, a visualization
choice, an unexpected Python behavior, a debugging strategy, a modeling idea,
or an application of a course method.

Before writing, identify the chapter where the presentation belongs and ask
what the audience will understand or be able to do after viewing it. A narrow
question usually produces a more useful presentation than a broad survey.
You may either create a new presentation or improve an existing one. For
example, you could add a figure, correct an explanation, improve accessibility,
add a limitation, or extend an example in `topic/plot/`.

### 2. Create a branch and presentation directory

Work on a topic branch, not directly on `main`. The branch should describe the
contribution, whether it adds a new deck or improves an existing one:

```text
git switch main
git pull --ff-only
git switch -c topic/your-name-short-topic
```

The first command switches to the local `main` branch. The second updates it
from its remote after checking that the update can be applied without a merge
commit. The third command creates a new branch from the updated `main` and
switches to it; the `-c` option means “create.” Confirm the result with
`git branch --show-current`. You should see
`topic/your-name-short-topic` before editing any files.

For a revision to an existing deck, a name such as
`topic/your-name-plot-caption` is appropriate. One branch and pull request
should contain one focused contribution.

Create one directory for the presentation. Use a short, lowercase slug with
hyphens only when they improve readability:

```text
topic/your-name-short-topic/index.qmd
```

Examples in this repository use short slugs such as `plot` and `api`. The
directory should contain the source for one deck. Add small supporting files
inside that directory when needed:

```text
topic/plot/
├── index.qmd
├── data/
└── figures/
```

Use the repository's presentation profile when rendering; do not create a
separate Quarto project configuration in each presentation directory.

### 3. Write the presentation source

Copy the metadata pattern from one of the example presentations. Use `#` for
section slides and `##` for ordinary slides. A useful topic-presentation
sequence is:

1. **Motivation:** What question, problem, or decision makes the topic useful?
2. **Main idea:** Define the concept and any notation or terminology.
3. **Worked example:** Use a small example that the audience can follow.
4. **Code or method:** Show only the code needed to understand the example.
5. **Interpretation:** Explain what the output, table, or figure means.
6. **Limitations or mistakes:** Identify a trap, assumption, or poor practice.
7. **Takeaways:** End with two or three specific conclusions.

Use executable Python cells when computation is part of the explanation. Keep
the code short, import packages explicitly, and explain the output immediately
after showing it. Use a fixed random seed for random examples when practical.
Label figures and axes, provide useful alternative text for images, and use
relative paths for local files.

Every external claim, dataset, image, or borrowed idea needs attribution. Use
links or citations in the slides and list the sources on a final slide. Do not
include copyrighted material merely because it appeared in an image search,
and do not commit credentials, private data, or large raw datasets.

Keep the source readable and consistent with the course writing conventions:

- Keep prose, Markdown, and Quarto source lines under 80 characters. Wrap a
  long sentence rather than allowing one very long source line; code lines may
  be longer when shortening them would make the example less readable.
- Use the existing project metadata and configuration pattern. Do not add a
  second Quarto project configuration or unrelated global settings.
- Use a `### Further readings` or equivalent final-slide section when the
  presentation has useful resources beyond the sources cited in the slides.
- Use original explanations and examples. Do not copy another student's notes,
  an instructor-authored chapter, or external material without attribution.
- Use BibTeX for scholarly references when the presentation needs a formal
  citation; ordinary links are appropriate for documentation and web resources.

### 4. Add the catalog entry

The deck source and the catalog entry are one contribution. Add a short entry
to the topical chapter that best fits the presentation. Include the title, the
presenter, a link to the rendered deck, and a two- or three-sentence abstract.
For example:

```markdown
| Presentation | Presenter | Description |
|:--|:--|:--|
| [Reading a plot](../topic/your-name-short-topic/) | Your Name | Explains ... |
```

If the chapter has a simple list rather than a table, follow its existing
format. Do not add a deck to a chapter that is unrelated to its subject.

### 5. Render and inspect the deck

Use the shared Python 3.12 environment described in
[README.md](README.md#shared-python-environment). The book's
`requirements.txt` is the single source for dependencies; the semester file
only includes it. Request instructor approval for new packages and propose
them in `ids-book/requirements.txt`. Do not create a separate environment
for this repository.

Activate the course Python environment, then render only the presentation
while developing it:

```text
make render-one FILE=topic/your-name-short-topic/index.qmd
```

Open the resulting slides in a browser. Check that code runs, figures and
links appear, text fits on the slides, and the presentation can be understood
without access to your terminal. Search the source for accidental absolute
paths, credentials, or copied material. Check the repository status before
committing:

```text
git status --short
```

Generated HTML, `.quarto`, `_freeze`, notebook intermediates, and other build
products should remain uncommitted.

### 6. Commit, push, and open a pull request

Review the diff and stage named files explicitly:

```text
git diff -- topic/your-name-short-topic chapters/relevant-chapter.qmd
git add topic/your-name-short-topic chapters/relevant-chapter.qmd
git commit -m "content: add short topic presentation"
git push -u origin topic/your-name-short-topic
```

Open a pull request that explains the idea, identifies the relevant chapter,
and reports the rendering check. Keep the pull request focused on the deck and
its catalog entry. Respond to review comments with revisions and additional
small commits; do not rewrite unrelated files in the same pull request. Make
commits throughout the work as meaningful steps are completed rather than
waiting to record one large final snapshot. Do not create empty commits or
split changes artificially merely to increase the commit count.

Students submit pull requests rather than pushing changes directly to `main`.
The pull request is the place where the instructor and classmates can inspect
the source, discuss the idea, and request revisions. After review, the
instructor or designated maintainer merges the pull request and renders the
complete site. A contribution can receive credit for thoughtful work and
revision even if it is not ultimately accepted into the published notes.

### A live classroom demonstration

The following is a complete small contribution that can be demonstrated in
class. Assume that the class is adding a better axis label to the `plot`
example:

```text
git switch main
git pull --ff-only
git switch -c topic/your-name-plot-label
```

Edit `topic/plot/index.qmd`, make the focused change, and render the deck:

```text
make render-one FILE=topic/plot/index.qmd
git diff -- topic/plot/index.qmd
git status --short
```

If the slides look correct, stage only the intended source file, commit it,
and push the branch:

```text
git add topic/plot/index.qmd
git commit -m "fix: clarify plot axis label"
git push -u origin topic/your-name-plot-label
```

Open a pull request from `topic/your-name-plot-label` into `main`. In the pull
request description, state what changed, why it helps the audience, and that
`make render-one FILE=topic/plot/index.qmd` completed successfully. Reviewers
can then comment on the source and the rendered slides, and the contributor
can push revisions to the same branch.

### What the commands do

The commands in this workflow each have a separate purpose:

- `git status --short` reports changed, staged, and untracked files in a
  compact form.
- `git branch --show-current` prints the branch that is currently checked out.
- `git switch main` changes the current branch to `main` without creating a
  branch.
- `git pull --ff-only` downloads updates and moves the current branch forward
  only when Git can do so without creating a merge commit.
- `git switch -c branch-name` creates a new branch at the current commit and
  switches to it. The `-c` means “create.”
- `make render-one FILE=path/to/index.qmd` runs the repository's Makefile
  target to render one presentation. It does not create a Git commit.
- `git diff -- path/to/file` shows unstaged edits to a specified file.
- `git add path/to/file` stages the named file for the next commit; it does
  not publish the file or commit it.
- `git diff --staged` shows exactly what is currently staged for the next
  commit.
- `git commit -m "message"` records the staged snapshot in local Git history.
  The message should briefly describe one logical change.
- `git push -u origin branch-name` uploads the branch and its commits to the
  student's fork. The `-u` records the remote tracking branch for later pushes.
- `git log --oneline --decorate` summarizes the branch history, while
  `git show COMMIT` displays the files and changes recorded by one commit.
- `git remote -v` lists the URLs represented by names such as `origin` and
  `upstream`.
- `git fetch upstream` downloads the course repository's latest history
  without changing the student's working files.
- `git merge --ff-only upstream/main` updates the local `main` branch from the
  course repository only when the update can be applied without a merge
  commit.
- `git branch -d branch-name` removes a finished local branch after its work
  has been merged or is safely available elsewhere.
- `git push origin --delete branch-name` removes the finished branch from the
  student's fork. It does not delete the merged contribution or pull request.

The distinction between working files, staged changes, local commits, and
remote commits is important: editing changes the working tree, `git add`
selects changes for a snapshot, `git commit` records that snapshot locally, and
`git push` sends the commits to GitHub.

### After the pull request is reviewed

The instructor or another designated maintainer accepts a contribution from
the pull request page. The maintainer should:

1. Check the rendered presentation and the source diff.
2. Confirm that the catalog entry, if needed, points to the correct deck.
3. Leave review comments or request changes when revisions are needed.
4. Merge the pull request after the contribution is ready. Squash-merging is a
   useful default for a small educational contribution because it keeps the
   `main` history focused, although preserving separate commits is also fine
   when the revision history is itself useful for teaching.
5. Delete the pull-request branch after merging when it is no longer needed.

On GitHub, the maintainer can use **Merge pull request** (or **Squash and
merge**) and then **Delete branch**. Deleting the branch does not delete the
merged files or the pull request; it only removes the branch reference. The
maintainer should not delete `main`. If a pull request needs more work, use
**Request changes** or leave comments and keep the branch open.

The branch may belong to the student's fork rather than the course
repository. A maintainer should delete it only when the pull request has been
merged or the contributor has confirmed that it is no longer needed. GitHub's
**Delete branch** button handles the remote branch when the maintainer has the
necessary permission.

### After a student's pull request is merged

The student should synchronize the `main` branch of their fork and remove the
finished topic branch. The easiest option is to use the **Sync fork** button
on the fork's GitHub page. From a terminal, the equivalent workflow is:

```text
git remote -v
# Run the next command only if `upstream` is missing.
git remote add upstream https://github.com/statds/ids-f26.git
git fetch upstream
git switch main
git merge --ff-only upstream/main
git push origin main
git branch -d topic/your-name-plot-label
git push origin --delete topic/your-name-plot-label
```

Here, `upstream` is the course repository and `origin` is the student's fork.
Run the `git remote add upstream` command only if `upstream` is not already
listed by `git remote -v`; `origin` should point to the student's fork. A
student should not delete the
branch until the pull request is merged or closed and the work is safely
available elsewhere. If a local branch cannot be deleted because Git reports
that it is not fully merged, stop and verify the pull request status rather
than forcing deletion.

For the next contribution, start from the newly synchronized `main` branch
and create a new focused branch. Reusing an old branch can accidentally add
earlier commits or make the next pull request difficult to review.

Review considers technical correctness, reproducibility, clarity,
accessibility, attribution, and whether the presentation adds something useful
to the notes. Editorial acceptance and course assessment are separate
decisions.

## Final-project presentations

Final-project presentations use the same folder, branch, rendering, and pull
request workflow. Put each project in its own short, descriptive directory:

```text
final/short-project-name/index.qmd
```

The deck should tell a complete project story: question, motivation, data,
method, evidence, interpretation, limitations, and conclusions. Include the
project collaborators in the metadata and catalog entry. Keep private or
sensitive data out of the repository, document public data sources, and make
the analysis reproducible with small local files or clearly documented
download steps when possible.

Add the catalog entry to `chapters/final-project-presentations.qmd`. The
instructor renders the complete site after accepted pull requests are merged.

## Examples

The following examples are intentionally labeled and are meant to show the
expected organization and level of detail:

- [Topic: Reading a plot](topic/plot/)
- [Topic: Working with an API](topic/api/)
- [Final project: Health survey](final/health/)
- [Final project: Rental prices](final/rent/)
