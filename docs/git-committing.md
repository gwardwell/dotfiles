# Commit Messages

> Run through [this amazing course](https://learngitbranching.js.org/) to learn how to Git better (pun intended).

This document outlines our commit message format. It's extremely important that you follow this format. Read on to learn why!

- [TL;DR](#tldr)
- [Why have a commit format?](#why-have-a-commit-format)
- [Our commit message format](#our-commit-message-format)
- [Examples](#examples)
- [Line length](#line-length)
- [Header](#header)
- [Body](#body)
- [Footer](#footer)
- [Breaking changes](#breaking-changes)
- [Skipping CI jobs](#skipping-ci-jobs)
- [Commit message template](#commit-message-template)
- [Thanks to...](#thanks-to)

## TL;DR

- [Use the commit message template](#commit-message-template).
- The [header](#header), its [type](#type), and [subject](#subject) are mandatory
- The [header scope](#scope), [body](#body), and [footer](#footer) are optional
- The header line length [cannot be longer than 50 characters](#line-length).
- All non-header lines of the commit message [cannot be longer 72 characters](#line-length).
- If you're closing an issue, include a closing reference to an issue in the footer ([GitHub](https://docs.github.com/en/issues/tracking-your-work-with-issues/linking-a-pull-request-to-an-issue) | [GitLab](https://docs.gitlab.com/ee/user/project/issues/managing_issues.html#closing-issues-automatically)).

## Why have a commit format?

Following a commit format allows for some really useful things:

- Automatically generating releases and changelogs using [`semantic-release`](https://github.com/semantic-release/semantic-release).
- Automatically determining a semantic version bump (based on the types of commits landed).
- Communicating the nature of changes to teammates, the public, and other stakeholders.
- Triggering build and publish processes.
- Making it easier for people to contribute to your projects, by allowing them to explore a more structured commit history.

## Our commit message format

Each commit message can consist of a [header](#header), a [body](#body) and a [footer](#footer). The header is mandatory, but the body and footer are optional. The header has a special format that includes a [type](#type), a [scope](#scope) and a [subject](#subject):

```plaintext
<type>(<scope>): <subject>

<body>

<footer>
```

## Examples

Commit message with description and breaking change in the footer:

```plaintext
feat: allow config object to extend other configs

BREAKING CHANGE: `extends` key in config file is now used for extending
other config files
```

Commit message with no body:

```plaintext
docs: correct spelling of CHANGELOG
```

Commit message with scope:

```plaintext
feat(lang): add polish language
```

Commit message for a fix using an (optional) issue number.

```plaintext
fix: correct minor typos in code

see the issue for details on the typos fixed

fixes issue #12
```

## Line length

The header line length cannot be longer than 50 characters.

All non-header lines of the commit message cannot be longer than 72 characters.

## Header

The header has a special format that includes a [type](#type), a [scope](#scope) and a [subject](#subject). It format looks like this:

```plaintext
<type>(<scope>): (this commit will...) <subject>
```

### Type

The type, along with [`BREAKING CHANGE`](#breaking-changes), is one of the most important parts of your commit message. For projects that have implemented our [`semantic-release` project](), it provides the context on which release versioning decisions are made. The type should _always_ be lowercase and must be one of the following:

| type       | description                                                                                                 | [Semantic Versioning](https://semver.org/) release |
| ---------- | ----------------------------------------------------------------------------------------------------------- | -------------------------------------------------- |
| `chore`    | Changes that affect the build system or external dependencies (example scopes: gulp, broccoli, npm)         | none                                               |
| `ci`       | Changes to our CI configuration files and scripts (example scopes: Travis, Circle, BrowserStack, SauceLabs) | none                                               |
| `docs`     | Documentation only changes                                                                                  | none                                               |
| `feat`     | A new feature                                                                                               | **MINOR** version (`1.0.0` => `1.1.0`)             |
| `fix`      | A bug fix                                                                                                   | **PATCH** version (`1.0.0` => `1.0.1`)             |
| `perf`     | A code change that improves performance                                                                     | **PATCH** version (`1.0.0` => `1.0.1`)             |
| `refactor` | A code change that neither fixes a bug nor adds a feature                                                   | none                                               |
| `style`    | Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)      | none                                               |
| `test`     | Adding missing tests or correcting existing tests                                                           | none                                               |

> **NOTE:** The semantic versioning release for each `type` listed in the table above are accurate, but including [`BREAKING CHANGE`](#breaking-changes) in your commit will make all types release as a **MAJOR** version (`1.0.0` => `2.0.0`).

### Scope

Optional scopes are can be paired with types to provide further specificity and grouping to commits. They should be added directly after the type and enclosed in parenthesis. Here's an example where `checkout` is the scope:

```plaintext
feat(checkout): change how CC is processed
```

Scopes should typically be custom tailored to each project's commit template. Scopes are optional, so if you don't see a scope in your project's commit template that is fitting for your change, simply omit the scope.

### Subject

The subject contains a succinct description of the change:

- use the imperative, present tense: "change" not "changed" nor "changes". The easiest way to achieve this is to continue the sentence "This commit will...". This allows the subject to speak to what the commit accomplishes, not what the developer did.
- don't capitalize the first letter
- no period (`.`) at the end

### Header examples

A feature commit, without scope:

```plaintext
feat: allow config object to extend other configs
```

A docs commit, without scope:

```plaintext
docs: correct spelling of CHANGELOG
```

A feature commit, with scope:

```plaintext
feat(lang): add polish language
```

A fix commit, without scope:

```plaintext
fix: correct minor typos in code
```

## Body

The body should include the motivation for the change and contrast the change with the previous behavior:

- Include an empty line between the header of your commit message and the body
- Just as in the **subject**, use the imperative, present tense: "change" not "changed" nor "changes"
- the body can include as many lines as you feel are necessary, but it doesn't need to be a book
- You can include lists by breaking the body into multiple lines started with a dash (`-`)
- You can reference issues included in your footer for more info

A verbose commit message body:

```plaintext
In an overloaded method, the overload with the function body is the
actual method doc, and this doc is not included in the list of
"additional" overloads.

Moreover, the logic (all in dgeni-packages) is that if none of the items
has a body then we use the first overload as the actual method doc.

In the case of abstract methods, none of the methods have a body. So we
have a situation where the overloads collection does not contain the
first abstract method, even though it is not the "implementation" of the
method. Therefore we need to still render it.
```

A commit message body with a bulleted list:

```plaintext
- Add link to "Very Basic Concept of Git"
- Add link to "Learning How To Git: Your First Commit"
- Add link to "Learning How To Git: Push Commits To Remote Repository"
```

The body referencing an included issue (in the footer) for more info:

```plaintext
see the issue for details on the typos fixed
```

## Footer

The footer should contain any information about **Breaking Changes** and is also the place to reference GitHub issues that this commit **Closes**.

### Closing issues

Both GitHub and GitLab can auto-close issues if your commit messages include text that matches a specific pattern ([GitHub docs](https://docs.github.com/en/issues/tracking-your-work-with-issues/linking-a-pull-request-to-an-issue) | [GitLab docs](https://docs.gitlab.com/ee/user/project/issues/managing_issues.html#closing-issues-automatically)).

You can reference:

1. a local issue (`#123`)
2. a cross-project issue (`owner/repo#123` on GitHub, `group/project#123` on GitLab)
3. a link to an issue (full URL)

To close an issue, include one of the following closing keywords with the issue reference:

- Close, Closes, Closed, Closing, close, closes, closed, closing
- Fix, Fixes, Fixed, Fixing, fix, fixes, fixed, fixing
- Resolve, Resolves, Resolved, Resolving, resolve, resolves, resolved, resolving
- Implement, Implements, Implemented, Implementing, implement, implements, implemented, implementing

Closing an issue by issue number:

```plaintext
Closes #25610
```

Closing a cross-project issue:

```plaintext
# GitHub
Closes owner/repo#123

# GitLab
Closes group/project#123
```

Closing an issue by URL:

```plaintext
# GitHub
Closes https://github.com/owner/repo/issues/23

# GitLab
Closes https://gitlab.example.com/group/project/issues/23
```

Closing multiple issues:

```plaintext
Closes #1, #2, and #3
```

Closing multiple issues across projects:

```plaintext
# GitHub
Closes #25610, owner/repo#123, and https://github.com/org/project/issues/23

# GitLab
Closes #25610, group/project#123, and https://gitlab.example.com/group/project/issues/23
```

### Additional references

You can include any links to additional references in your footer. These can include:

- Wrike tasks
- issues that this commit is related to, but does not close/solve
- third party package issues
- StackOverflow links
- or anything else that helps explain your change

Linking to a related issue not being closed:

```plaintext
Related to #11626.
```

Linking to an issue in another project not being closed:

```plaintext
Related to group/project#123.
```

Linking to a Wrike task:

```plaintext
Wrike task https://www.wrike.com/open.htm?id=266842946.
```

## Breaking changes

**Breaking Changes** should be the very last section of your footer. It should start with the words `BREAKING CHANGE:` followed by either a single or an empty line. This section can follow the same formatting rules as the [body](#body).

Breaking changes on any commit with any type will change the commit's [sematic versionin](https://semver.org/) to a **MAJOR** version (`1.0.0` => `2.0.0`).

> **Note:** adding `breaking change` in any form (`Breaking change`, `BREAKING CHANGE`, `bReAkInG cHaNgE`) at the beginning of a line will result in the commit being treated as a breaking change. Including it in the header or body in the middle of text will have no effect on the release version.

A one-line breaking change:

```plaintext
BREAKING CHANGE: `extends` key in config file is now used for extending
other config files
```

A multi-line breaking change:

```plaintext
BREAKING CHANGE:

`extends` key in config file is now used for extending
other config files
```

## Skipping CI jobs

If your commit message contains `[ci skip]` or `[skip ci]`, using any capitalization, the commit will be created but the pipeline will be skipped.

- [GitHub Actions: Skipping workflows](https://docs.github.com/en/actions/managing-workflow-runs/skipping-workflow-runs)
- [GitLab CI: Skipping jobs](https://docs.gitlab.com/ee/ci/pipelines/#skip-a-pipeline)

## Commit message template

We've created a Git commit template to help you apply these rules to your commits. Use the following instructions to get the template plugged into your Git workflow.

### Global commit message template

Follow these instructions to add a Git commit message template that will be used for all Git commits:

1. save [this Git commit template file](../templates/git-commit-template.md) to your local machine
2. run `git config --global commit.template <git-commit-template.txt file path>` in your terminal app. For example, if you saved it to your home folder, try: `git config --global commit.template ~/git-commit-template.txt`

### Project specific commit message template

Follow these instructions to add a Git commit message template to a specific project:

> Note: This template will _override_ your global Git commit template (which is what we want).

1. save [this Git commit template file](../templates/git-commit-template.md) to the root of your project under the name `.git-commit-template.txt`
2. in your terminal app, navigate to your project
3. run `git config commit.template .git-commit-template.txt` in your terminal app

### Editing your commit message

You can configure Git to use VIM (default) or another text editor/IDE as its default editor. You can [learn how to change your editor here](./git-editor.md).

## Thanks to...

- [adeekshith/.git-commit-template.txt](https://gist.github.com/adeekshith/cd4c95a064977cdc6c50)
- [Conventional Commits](https://conventionalcommits.org/)
- [Angular's Commit Message Guidelines](https://github.com/angular/angular/blob/22b96b9/CONTRIBUTING.md#-commit-message-guidelines)
- [Git Commits: Past or Imperative?](https://www.danclarke.com/git-tense)
- [GitHub Actions: Skipping workflows](https://docs.github.com/en/actions/managing-workflow-runs/skipping-workflow-runs)
- [GitLab CI: Skipping jobs](https://docs.gitlab.com/ee/ci/pipelines/#skip-a-pipeline)
