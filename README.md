# NixOS DevSecOps Pipeline

A GitHub Actions pipeline that checks NixOS configuration and improves infrastructure security.

## Tools

- **GitHub Actions** — automates checks.
- **Statix** — checks Nix code quality.
- **Deadnix** — finds unused Nix code.
- **nixfmt** — checks formatting.
- **actionlint** — checks GitHub Actions workflows.
- **zizmor** — audits workflow security.
- **Gitleaks** — scans for exposed secrets.

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

Put your main managed NixOS settings inside:

```text
/etc/nixos/nixos-devsecops-pipeline/configuration.nix
```

Keep `hardware-configuration.nix` in `/etc/nixos`, outside the repository.

## Run the Pipeline

```bash
cd /etc/nixos/nixos-devsecops-pipeline

git add README.md configuration.nix .github/workflows/nixos-devsecops.yml
git commit -m "Update NixOS DevSecOps pipeline"
git push
```

Open your GitHub repository and select **Actions** to view the results.

## Apply Configuration Changes

Test the configuration first:

```bash
sudo nixos-rebuild build
```

If the build succeeds and you are ready to apply the changes:

```bash
sudo nixos-rebuild switch
```

Back up your configuration before making changes.

## Security

- Keep secrets and private keys out of Git.
- Review configuration before publishing the repository.
- Use least-privilege permissions in GitHub Actions.
- Review and fix failed security checks.
- Remember that passing CI checks does not guarantee complete OS security.
