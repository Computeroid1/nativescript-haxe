# Contributing to nativescript-haxe

Thank you for your interest in contributing to nativescript-haxe! This document provides guidelines and instructions for contributing.

## Code of Conduct

- Be respectful and inclusive
- Provide constructive feedback
- Focus on what is best for the community

## How to Contribute

### Reporting Bugs

Before creating bug reports, please check existing issues. When creating a bug report, include:

- A clear and descriptive title
- Steps to reproduce the issue
- Expected behavior
- Actual behavior
- Screenshots if applicable
- Environment details (OS, Haxe version, etc.)

### Suggesting Features

Feature requests are welcome! Please include:

- Clear use case
- Expected API design
- Example code if possible
- Rationale for the feature

### Pull Requests

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Add tests if applicable
5. Ensure the code compiles (`make build`)
6. Commit your changes with clear messages
7. Push to your fork
8. Open a Pull Request

### Coding Standards

- Follow existing code style
- Use meaningful variable and function names
- Add comments for complex logic
- Keep functions focused and small
- Maintain type safety

### Component Development

When adding new components:

1. Add VNodeType enum entry
2. Create component class extending Component
3. Implement toVNode() method
4. Update platform adapters
5. Add documentation
6. Add example usage

### Testing

- Ensure code compiles: `make build`
- Test on Android: `make android`
- Test on Windows: `make windows`
- Add examples to template app

### Documentation

- Update README.md for new features
- Add inline code documentation
- Include usage examples
- Update API reference

## Project Structure

```
nativescript-haxe/
├── library/src/ns/
│   ├── core/      - Core framework
│   ├── ui/        - UI components
│   └── platform/  - Platform adapters
├── template/      - Example app
└── scripts/       - Build scripts
```

## Questions?

Feel free to open an issue for questions or discussions.

Thank you for contributing! 🎉