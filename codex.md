# `ids-f26` Project Instructions for Codex

## Project Purpose

`ids-f26` is the semester-specific, student-contributed notes repository for the Fall 2026 Introduction to Data Science course.

This repository is **not** the canonical instructor-authored course book. Its purpose is to support collaborative learning, student authorship, and authentic Git/GitHub practice.

The long-term instructor-controlled notes live separately in `ids-book`.

## Relationship to `ids-book`

Keep the two repositories conceptually distinct:

- **`ids-book`**: canonical instructor notes; tightly controlled; semester-independent where practical; designed to grow into a future book.
- **`ids-f26`**: Fall 2026 collaborative student notes; semester-specific; supplements the instructor notes.
- **Classroom 50 repositories**: private graded assignments and assessment workflows.

Do not duplicate substantial instructor-authored exposition from `ids-book` into `ids-f26`.

Where useful, student notes should link to the relevant section or chapter of `ids-book` and then add student-created explanations, examples, extensions, or troubleshooting notes.

## Intended Student Contributions

Appropriate contributions include:

- worked examples;
- alternative explanations of course concepts;
- Python demonstrations;
- visualizations;
- debugging notes;
- common mistakes and how to avoid them;
- extensions or applications;
- summaries of useful class discussions;
- links to useful external resources with proper attribution.

The collaborative notes should answer questions such as:

- What helped students understand this topic?
- What examples clarified the idea?
- What mistakes occurred repeatedly?
- What useful extensions or applications did students discover?

## Contribution Structure

Prefer a consistent structure for student-authored sections.

A typical contribution should contain:

1. **What** — a concise explanation of the concept.
2. **Example** — preferably an executable Python example.
3. **Interpretation** — explain what the result means.
4. **Takeaway** — one or two key conclusions.
5. **Sources** — cite external sources where appropriate.

Not every contribution must use all five headings literally, but the underlying elements should usually be present.

## Git/GitHub Workflow

Use a real collaborative workflow rather than unrestricted direct editing.

Preferred sequence:

```text
topic or issue
    -> branch
    -> commits
    -> pull request
    -> review
    -> revision
    -> merge
```

Codex should encourage students to:

- make focused changes;
- use meaningful branch names;
- make small, coherent commits;
- write informative commit messages;
- open pull requests rather than pushing directly to the main branch;
- respond to review comments;
- revise before merge;
- avoid unrelated changes in the same pull request.

## Review Philosophy

For students, Codex should default to **review and explanation**, not silent rewriting.

When asked to check a contribution:

- identify concrete problems;
- explain the relevant convention;
- distinguish errors from suggestions;
- preserve the student's authorship;
- avoid rewriting large portions of prose unless explicitly asked;
- prioritize correctness, reproducibility, clarity, and consistency.

The goal is for students to learn from the review rather than outsource the work.

## Pre-Commit Check

Before a commit or pull request, use the shared `stat-writing-check` skill when available.

Typical student request:

> Check my changes before I commit.

The check should cover, as applicable:

- file naming;
- Git hygiene;
- generated or accidental files;
- Quarto/Markdown conventions;
- LaTeX conventions;
- executable Python examples;
- citations and references;
- reproducibility;
- selected statistical-writing conventions.

For students, default to reporting issues rather than automatically fixing prose.

For mechanical violations, Codex may suggest exact fixes.

## Shared `stat-writing-check` Skill

The writing and workflow conventions are maintained outside this repository in the `stat-writing` project.

`stat-writing` is the source of truth for reusable conventions such as:

- file naming;
- Git practices;
- LaTeX;
- Quarto/Markdown;
- references and citations;
- statistical writing.

The reusable Codex skill is expected to live conceptually under:

```text
stat-writing/
└── skills/
    └── stat-writing-check/
        ├── SKILL.md
        ├── references/
        └── scripts/
```

A local Codex installation may expose that skill through a Codex skills directory, for example via a symbolic link:

```bash
mkdir -p ~/.codex/skills

ln -s ~/work/stat-writing/skills/stat-writing-check \
      ~/.codex/skills/stat-writing-check
```

Do not copy the full `stat-writing` rules into this repository.

## Content Boundaries

Do not treat `ids-f26` as the place for:

- the authoritative instructor manuscript;
- long-term textbook development;
- private graded work;
- answer keys;
- sensitive student information;
- semester administration that belongs elsewhere;
- copied material from external sources without attribution.

If material belongs in the long-term instructor book, prefer proposing it for `ids-book` rather than incorporating it here as canonical content.

## Grading and Editorial Acceptance

Do not assume that a contribution must be merged in order to earn credit.

Where collaborative-note work is assessed, emphasize the process:

- meaningful contribution;
- correct use of Git/GitHub;
- clear commits and pull requests;
- responsiveness to review;
- revision quality;
- reproducibility;
- technical correctness;
- constructive peer review.

Editorial acceptance and grading should remain conceptually separate.

## Reproducibility

Use one Python 3.12 environment for the book, semester notes, and coursework.
`ids-book/requirements.txt` is the single source for package versions. The
semester requirements file includes `../ids-book/requirements.txt`, assuming
side-by-side checkouts; for other layouts, install from the book directory.
Do not create another environment here or replace the include with a frozen
package list. Propose new dependencies in the book repository for instructor
approval. See `README.md` for the setup workflow.

Python examples should be runnable and minimal.

Prefer:

- explicit imports;
- reproducible examples;
- stable package usage;
- small datasets or clearly documented external data sources;
- deterministic output where practical;
- fixed random seeds when randomness is used.

Avoid unnecessary dependencies.

Do not commit generated output or cache files unless the project explicitly requires them.

## File Organization

Use clear, descriptive, consistent file names.

Prefer lowercase names with hyphens where appropriate.

Examples:

```text
git-basics.qmd
python-functions.qmd
data-visualization.qmd
```

Avoid:

```text
My Notes.qmd
chapterFinal2.qmd
new_version_latest.qmd
```

Follow the shared `stat-writing` file-naming conventions when available.

## Quarto Project

Treat `ids-f26` as a semester-specific collaborative Quarto notes site/book.

Codex should:

- preserve the project structure;
- update `_quarto.yml` carefully;
- avoid renumbering/reorganizing large parts of the project without need;
- keep navigation coherent;
- ensure cross-references continue to work;
- avoid committing `_book/`, `.quarto/`, notebook checkpoints, or similar generated files unless intentionally configured otherwise.

## Working Principle

The three components of the course have different roles:

```text
ids-book
    = what the instructor wants students to learn

ids-f26
    = what the class collectively learns and contributes

Classroom 50
    = where students practice and are assessed
```

Codex should preserve this separation when suggesting changes.

## Long-Term Value

At the end of the semester, `ids-f26` can serve as feedback on `ids-book`.

Useful signals include:

- recurring misconceptions;
- topics needing clearer explanations;
- especially effective examples;
- useful alternative explanations;
- interesting applications;
- gaps in the instructor notes.

These insights may inform later revisions of `ids-book`, while `ids-book` remains independently authored and editorially controlled.
