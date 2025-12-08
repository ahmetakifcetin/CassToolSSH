# Contributing to CassMarrow

First off, thank you for considering contributing to CassMarrow! It's people like you that make CassMarrow such a great tool for the self-hosting community.

## 🌟 How Can I Contribute?

### Reporting Bugs

Before creating bug reports, please check the existing issues to avoid duplicates. When you create a bug report, include as many details as possible:

**Bug Report Template:**
- **Description**: Clear description of the bug
- **Steps to Reproduce**: Detailed steps to reproduce the issue
- **Expected Behavior**: What you expected to happen
- **Actual Behavior**: What actually happened
- **Environment**: 
  - OS and version (e.g., Ubuntu 24.04)
  - Shell version
  - CassMarrow version
- **Screenshots/Logs**: If applicable

### Suggesting Features

Feature suggestions are welcome! Please provide:

- **Clear description** of the feature
- **Use case**: Why this feature would be useful
- **Possible implementation**: If you have ideas on how to implement it
- **Examples**: Screenshots or mockups if applicable

### Pull Requests

1. **Fork the repository** and create your branch from `main`
2. **Follow the coding style** used throughout the project
3. **Test your changes** thoroughly
4. **Update documentation** if needed
5. **Write good commit messages**

## 📝 Coding Guidelines

### Bash Script Style

- Use 4 spaces for indentation (no tabs)
- Maximum line length: 100 characters
- Use meaningful variable names
- Add comments for complex logic
- Use `local` for function variables
- Always quote variables: `"$variable"`
- Use `[[` instead of `[` for conditionals
- Use `$()` instead of backticks

**Example:**

```bash
# Good
get_memory_usage() {
    local total_mem used_mem
    total_mem=$(free -m | awk 'NR==2{print $2}')
    used_mem=$(free -m | awk 'NR==2{print $3}')
    echo "${used_mem}MB / ${total_mem}MB"
}

# Bad
get_memory_usage() {
    total=`free -m | awk 'NR==2{print $2}'`
    used=`free -m | awk 'NR==2{print $3}'`
    echo $used"MB / "$total"MB"
}
```

### Function Naming

- Use lowercase with underscores: `get_system_info`
- Start with verb: `check_service`, `display_stats`, `format_output`
- Be descriptive: `get_docker_container_count` instead of `get_count`

### Comments

```bash
# Single-line comments for brief explanations

# Multi-line comments for complex logic:
# This function does X by:
# 1. First step
# 2. Second step
# Returns: formatted string
```

## 🎨 Adding New Features

### New ASCII Art Styles

1. Create your ASCII art using tools like [patorjk.com](http://patorjk.com/software/taag/)
2. Add a new case in the `print_ascii_art()` function
3. Test with different terminal widths
4. Update README.md with the new style

### New Color Themes

1. Add color definitions in the color switch statement
2. Test on different terminals (dark/light backgrounds)
3. Ensure readability
4. Update documentation

### New System Information

1. Create a helper function (e.g., `get_network_stats()`)
2. Add configuration option to toggle it
3. Add to the main display section
4. Update configuration documentation

## 🧪 Testing

Before submitting a PR, test your changes on:

- [ ] Ubuntu 24.04
- [ ] Ubuntu 22.04
- [ ] Debian 12
- [ ] Different terminal emulators (if UI changes)
- [ ] With configuration options on/off
- [ ] Fresh installation

### Manual Testing Script

```bash
# Test installation
sudo ./install.sh

# Test all configurations
sudo /opt/cassmarrow/customize.sh

# Test uninstallation
sudo /opt/cassmarrow/uninstall.sh
```

## 📚 Documentation

Update documentation for:

- New features → README.md
- Configuration changes → README.md and comments in config file
- Breaking changes → CHANGELOG.md
- Installation changes → install.sh comments

## 🔄 Pull Request Process

1. **Update the README.md** with details of changes if needed
2. **Update the CHANGELOG.md** with your changes
3. **Ensure all tests pass** and the code works on supported systems
4. **Request review** from maintainers
5. **Address feedback** promptly and professionally

### PR Title Format

Use conventional commits format:

- `feat: add new ASCII art style`
- `fix: correct memory calculation`
- `docs: update installation instructions`
- `style: improve code formatting`
- `refactor: simplify service checking`
- `test: add installation tests`

### PR Description Template

```markdown
## Description
Brief description of what this PR does

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Testing
- [ ] Tested on Ubuntu 24.04
- [ ] Tested on Debian 12
- [ ] Manual testing performed

## Screenshots (if applicable)
Add screenshots here

## Checklist
- [ ] Code follows the style guidelines
- [ ] Documentation updated
- [ ] No new warnings
- [ ] Testing completed
```

## 🎯 Good First Issues

Look for issues labeled `good first issue` or `help wanted`. These are great starting points for new contributors.

### Ideas for First Contributions

- Add new ASCII art styles
- Create new color themes
- Improve error messages
- Add more system information displays
- Write tests
- Improve documentation
- Fix typos

## 💬 Communication

- **GitHub Issues**: Bug reports and feature requests
- **GitHub Discussions**: General questions and ideas
- **Pull Requests**: Code contributions

Be respectful and constructive in all communications.

## 📜 Code of Conduct

### Our Pledge

We are committed to providing a welcoming and inspiring community for all.

### Our Standards

**Positive behavior includes:**
- Being respectful and inclusive
- Accepting constructive criticism
- Focusing on what's best for the community
- Showing empathy towards others

**Unacceptable behavior includes:**
- Harassment or discriminatory language
- Trolling or inflammatory comments
- Personal or political attacks
- Publishing others' private information

## 🏆 Recognition

Contributors will be:
- Listed in the README.md contributors section
- Mentioned in release notes for significant contributions
- Given credit in commit messages

## 📞 Questions?

Don't hesitate to ask questions! You can:
- Open a GitHub Discussion
- Comment on an existing issue
- Reach out to maintainers

## 🙏 Thank You!

Every contribution, no matter how small, is valuable. Thank you for helping make CassMarrow better!

---

**Happy Contributing! 🚀**
