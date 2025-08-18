# 💻 GitHub Workflow Guide

This document outlines the standard GitHub workflow for our team. Adhering to this process is mandatory for maintaining a clean and manageable codebase.

## 1. The Golden Rule: Main is Sacred

The `main` branch is our single source of truth. It should always be stable and deployable.
-   **DO NOT** push directly to `main`.
-   All changes must be integrated via Pull Requests (PRs).

## 2. The Development Process

1.  **Create an Issue**: Before starting work, create a GitHub Issue that describes the task, feature, or bug. This is your work ticket.
2.  **Create a Branch**: From the `main` branch, create a new feature branch. Name it according to the convention in `CONTRIBUTING.md` (e.g., `feature/add-login-page`).
3.  **Commit Your Work**: Make your changes on the branch. Commit often with clear, descriptive messages (e.g., `feat: build login form UI`).
4.  **Create a Pull Request**: When your work is ready for review, create a PR from your branch to `main`. Link the PR to the issue it resolves.
5.  **Code Review**: At least one other team member must review the PR, providing feedback or approval.
6.  **Merge**: Once approved, the PR can be merged into `main`. Delete the feature branch after merging.

## 3. Folder Structure

| Folder/File Path | Purpose |
|---|---|
| `/` | The root contains the `README`, `CONTRIBUTING.md`, and license. |
| `/.github/` | Holds GitHub-specific files like issue and PR templates. |
| `/docs/` | All documentation, guides, and meeting notes. |
| `/templates/` | Reusable templates for reports, etc. |
| `/src/` | Project source code. |
| `/designs/` | Design assets, like Figma links or mockups. |