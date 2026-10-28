# NixOS DevSecOps Pipeline

A DevSecOps project that uses GitHub Actions to check NixOS configuration quality and improve infrastructure security.

## Tools

- **NixOS / Nix** — declarative system configuration.
- **GitHub Actions** — automated CI pipeline.
- **Statix** — Nix code quality.
- **Deadnix** — unused Nix code detection.
- **nixfmt** — Nix formatting.
- **actionlint** — GitHub Actions linting.
- **zizmor** — GitHub Actions security auditing.
- **Gitleaks** — secret scanning.

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
