# NixOS DevSecOps Pipeline

A DevSecOps project that uses GitHub Actions to check NixOS configuration quality and improve infrastructure security.

## Tools

- **NixOS / Nix** — declarative system configuration.
- **GitHub Actions** — automated CI pipeline.
- **Statix** — Nix code quality.
• Official Docs / Repo: The primary source is the GitHub repository: https://github.com/oppiliappan/statix.
• Key Info: It lints Nix code for antipatterns and can auto-fix them (statix check, statix fix).
- **Deadnix** — unused Nix code detection.
• Official Source: Available via the NixOS package search or its GitHub repository: https://github.com/astro/deadnix.
• Key Info: Scans .nix files to find and help remove unused code.‌
- **nixfmt** — Nix formatting.
• Official Docs / Repo: The official repository is on GitHub: https://github.com/nixos/nixfmt.‌
• Key Info: It is the official formatter for the Nix language, maintained by the Nix formatting team.‌
- **actionlint** — GitHub Actions linting.
• Official Docs / Source: The Go package documentation serves as a central reference: https://pkg.go.dev/github.com/rhysd/actionlint.‌
• Key Info: A static checker that validates workflow syntax, expressions, and integrates security checks (like shellcheck).‌
- **zizmor** — GitHub Actions security auditing.
• Official Docs: The dedicated documentation site is https://docs.zizmor.sh/.‌
• Key Info: A static analysis tool for GitHub Actions that finds security issues like template injection, credential leakage, and excessive permissions.‌
- **Gitleaks** — secret scanning.
• Official Docs / Source: The Go package documentation covers usage and options: https://pkg.go.dev/github.com/zricethezav/gitleaks.‌
• Key Info: A SAST tool for detecting hardcoded secrets (passwords, API keys, tokens) in git repositories, files, or stdin.‌

## Project Structure

```text
/etc/nixos/
├── configuration.nix
├── hardware-configuration.nix
└── nixos-devsecops-pipeline/
    ├── configuration.nix
    ├── .github/
    │   └── workflows/
    │       └── nixos-devsecops.yml
    └── README.md
```

## NixOS Configuration

Keep `/etc/nixos/configuration.nix` as the main entry point:

```nix
{
  imports = [
    ./hardware-configuration.nix
    ./nixos-devsecops-pipeline/configuration.nix
  ];
}
```

Keep your main managed NixOS settings in:

```text
/etc/nixos/nixos-devsecops-pipeline/configuration.nix
```

Keep `hardware-configuration.nix` in `/etc/nixos`, outside the repository.

## Run the Pipeline

```bash
cd /etc/nixos/nixos-devsecops-pipeline

git add README.md configuration.nix .github/workflows/nixos-devsecops.yml
git commit -m "Update DevSecOps pipeline"
git push
```

Open your GitHub repository and select **Actions** to view the results.

## Disable GitHub Actions

To temporarily disable the workflow while keeping a backup:

```bash
cd /etc/nixos/nixos-devsecops-pipeline

mv .github/workflows/nixos-devsecops.yml \
   .github/workflows/nixos-devsecops.yml.disabled

git add -A
git commit -m "Disable GitHub Actions workflow"
git push
```

## Enable GitHub Actions Again

Restore the original workflow filename:

```bash
cd /etc/nixos/nixos-devsecops-pipeline

mv .github/workflows/nixos-devsecops.yml.disabled \
   .github/workflows/nixos-devsecops.yml

git add -A
git commit -m "Enable GitHub Actions workflow"
git push
```

Then open **GitHub → Actions** to check the workflow run.

## Apply NixOS Configuration Changes

Test the configuration first:

```bash
sudo nixos-rebuild build
```

If the build succeeds and you are ready to apply the changes:

```bash
sudo nixos-rebuild switch
```

Back up your configuration before making changes.

## Security Notes

- Never commit passwords, tokens, or private keys.
- Review machine-specific settings before making the repository public.
- Use least-privilege permissions in GitHub Actions.
- Review and fix failed security checks.
- GitHub Actions checks the repository; it does not automatically change your local machine.
- Passing CI checks does not guarantee complete operating-system security.
