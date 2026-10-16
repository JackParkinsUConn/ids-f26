# ids-f26

Student-developed collaborative notes for the Fall 2026 Introduction to Data
Science course.

These notes supplement the instructor-authored `ids-book`. Students contribute
RevealJS slide presentations containing examples, explanations,
visualizations, troubleshooting advice, applications, and other insights from
the semester. Topical chapters organize and link to topic presentations, while
the final-project chapter collects links to final-project presentations.

Private graded assignments and assessment materials belong in the designated
Classroom 50 repositories, not in this repository.

## Contributing

See [`CONTRIBUTING.md`](CONTRIBUTING.md) for the complete workflow and the
recommended structure for topic and final-project presentations.

Use a topic branch for each focused contribution. Make small, coherent
commits, push the branch, and open a pull request. Revise the contribution in
response to review before it is merged.

A new presentation contribution consists of:

1. a RevealJS source document in a dedicated, short-named directory under
   `topic/` or `final/`; and
2. a short catalog entry in the relevant file under `chapters/`.

Students improving an existing presentation should change the presentation
source and add or revise a catalog entry only when the title, description, or
placement changes.

The presentation should motivate the topic, explain its main idea, provide a
reproducible example, interpret the result, discuss limitations or common
mistakes, state its main takeaways, and attribute its sources. Students do not
rewrite the presentation as a prose section.

Keep examples minimal and reproducible. Use explicit imports, document data
sources and new dependencies, set random seeds when appropriate, and verify
that Quarto files render successfully. Do not commit generated output, cache
files, credentials, sensitive student information, or copied material without
proper attribution.

## Shared Python Environment

Use the same Python 3.12 environment for `ids-book`, `ids-f26`, and coursework.
Follow the
[book setup instructions](https://statds.github.io/ids-book/#building-the-book)
to create and activate it once. Do not create another environment or install
packages inside `ids-f26`.

Clone `ids-book` and `ids-f26` side by side:

```text
course-work/
├── ids-book/
└── ids-f26/
```

The book's `requirements.txt` is the single source for course package
versions. This repository's `requirements.txt` contains only an include of
`../ids-book/requirements.txt`; it has no separate package pins. With the
shared environment active, install or refresh dependencies from `ids-f26`
using:

```sh
make -C ../ids-book install
```

If your checkouts are not side by side, run `make install` from the actual
`ids-book` directory instead. The environment may live anywhere; activate
that same environment before rendering either repository.

Request instructor approval for new dependencies and propose approved
changes in `ids-book/requirements.txt`. Do not add package pins here or
overwrite this repository's include with `pip freeze`.

The Makefile assumes that the current shell is already inside the intended
environment; it does not create, select, or modify virtual environments.

## Rendering

Render one presentation while developing it:

```text
make render-one FILE=topic/last-name-topic/index.qmd
```

The repository includes two topic examples (`topic/plot/` and `topic/api/`)
and two final-project examples (`final/health/` and `final/rent/`). They use
invented data and are labeled as instructor-created examples.

Render the book and all accepted presentations:

```text
make render
```

Pull requests contain source files only. After review and merge, the instructor
renders and publishes the complete site.

## Commit Messages

Make each commit a coherent change. Use an imperative, concise subject without
a trailing period, preferably no longer than 72 characters. Commit messages
follow this format:

```text
type: concise imperative summary
```

Use these types:

- `content`: add or revise notes, examples, exercises, or explanations
- `feat`: add a structural or reader-facing capability
- `fix`: correct an error or broken behavior
- `build`: change Quarto, Python, dependency, or build configuration
- `style`: make formatting-only changes
- `refactor`: reorganize source without materially changing content
- `docs`: update repository or contribution documentation
- `chore`: perform repository maintenance

For example:

```text
content: add example of reshaping data
fix: correct axis labels in scatterplot
build: add pandas to the Python environment
docs: clarify pull request workflow
```

Add a commit body when the motivation or a non-obvious decision needs further
explanation. Reference a related issue in the body when applicable.

## Review

Review emphasizes technical correctness, reproducibility, clarity,
attribution, and constructive revision while preserving the contributor's
authorship. Editorial acceptance and course assessment are separate
decisions; a contribution does not have to be merged to receive credit.
