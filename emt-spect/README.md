# emt-spect

Cursor Agent Skill that acts as a Spect analyst: clarifies requirements interactively, then saves a focused SDD markdown file under `doc/`.

## Triggers

- `/emt-spect <description>`
- `$emt-spect <description>`
- Ask for a Spect or SDD document in chat (auto-invoked when relevant)

## Install

Place or symlink this folder in a skill directory Cursor discovers at startup:

| Path                          | Scope   |
| ----------------------------- | ------- |
| `.agents/skills/emt-spect/`   | Project |
| `.cursor/skills/emt-spect/`   | Project |
| `~/.agents/skills/emt-spect/` | Global  |
| `~/.cursor/skills/emt-spect/` | Global  |

```bash
mkdir -p .agents/skills
ln -s /path/to/emt-spect .agents/skills/emt-spect
```

Restart you AI or open a new Agent session after installing.

## Usage

```text
/emt-spect Allow users to export invoices as PDF from billing
```

1. The agent reads project context and your description.
2. If goal, actor, workflow, or success criteria are unclear, it asks **one** question and waits.
3. When clear enough, it drafts the Spect and saves it via `scripts/save_spect_doc.sh`.
4. Chat reply: saved path + any open questions — not the full document.

**Output:** `doc/<feature-kebab-case>.md`

## Generated document

Follows `assets/spect-template.md`:

- User stories (P1, P2, P3…) as independently testable journeys
- Functional requirements and success criteria
- Assumptions and open questions for unresolved items

The agent does not invent requirements; unknowns stay explicit.

## Requirements

- AI with Agent Skills support
- Bash for the save script (Git Bash, WSL, or MSYS2 on Windows)

## License

Apache-2.0 · v0.1 · gohan-rodolfo
