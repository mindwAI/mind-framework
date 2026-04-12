<p align="center">
  <strong>MIND Framework</strong>
</p>

<p align="center">
  Structure how AI agents work on your code.
</p>

<p align="center">
  <a href="CHANGELOG.md"><img src="https://img.shields.io/badge/version-0.1.0-blue" alt="version"></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/license-Apache%202.0-green" alt="license"></a>
</p>

---

## What is this?

AI agents are powerful but inconsistent. Without structure, they skip clarification, approve their own reviews, ignore project standards, and start every session from zero.

The MIND Framework fixes this with markdown files your agent reads before writing code:

- **Personas** define how each role behaves (developer, reviewer, QA)
- **Commands** define what to do at each pipeline step
- **Rules** define your project's standards
- **Templates** define the format of every artifact

It works with any AI agent that can read files. No vendor lock-in, no runtime, no dependencies.

### Why markdown?

Every AI coding tool — regardless of vendor — can read markdown from disk. By putting your engineering process in `.mind/*.md` files, you get a portable, version-controlled, human-readable governance layer that travels with your repo.

## Quick Start

### The easy path (one command)

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/mindwai/mind-framework/main/setup.sh)"
```

This clones the framework, copies `.mind/` into your current directory, generates `MIND.md`, and cleans up.

### The transparent path (see what you're installing)

```bash
git clone https://github.com/mindwai/mind-framework.git /tmp/mind
/tmp/mind/install.sh .
rm -rf /tmp/mind
```

### After install

```bash
cat MIND.md
```

Then open your AI agent and say:

> Read MIND.md and create a PRD for [describe your feature].

That's it. The agent reads the rules, adopts the persona, follows the command, and uses the template.

## What you get

```
.mind/
├── config.yaml       Pipeline definition
├── personas/          5 role behaviors (dev, reviewer, QA, writer, PO)
├── commands/          8 pipeline steps (PRD → techspec → tasks → implement → review → QA)
├── rules/             3 starter standards (code, git, tests)
└── templates/         4 artifact formats (PRD, techspec, QA checklist, feature)
```

Plus: `MIND.md` (agent index) and shim files so any AI tool finds the framework automatically.

See the full agent index in [MIND.md](MIND.md). Browse a complete example in [examples/hello-world/](examples/hello-world/).

## Framework vs mindwAI

| Use case | Framework (local, free) | mindwAI (hosted) |
|---|---|---|
| Solo developer | Full pipeline via markdown | Full pipeline + more |
| Code review | You set up the reviewer agent | Built-in review without config |
| Project memory | Git history | Remembers across sessions |
| Multiple features | Manual coordination | Scales without coordination work |
| Team collaboration | Git-based workflow | Built for teams |
| Setup | 1 command, zero dependencies | Account + API key |
| Cost | Free, open source | Free tier available |

The framework is the methodology. [mindwAI](https://mindwai.com) is the hosted service for teams that outgrow local markdown files.

## Documentation

- [Customization guide](docs/customization.md) — add personas, rules, templates
- [Writing personas](docs/writing-personas.md) — create new agent behaviors
- [Migration to mindwAI](docs/migration-to-mindwai.md) — when and why to consider hosted

## Contributing

Contributions welcome. Please:

1. Fork the repository
2. Create a feature branch
3. Submit a pull request

For major changes, open an issue first.

## License

[Apache 2.0](LICENSE) — use freely in personal and commercial projects.

---

<p align="center">
  <a href="https://github.com/mindwai/mind-framework">GitHub</a> · <a href="https://mindwai.com">mindwAI</a>
</p>
