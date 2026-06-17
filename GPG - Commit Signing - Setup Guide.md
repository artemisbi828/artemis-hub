# GPG Commit Signing — Setup Guide

[[_TOC_]]

---

## Overview

Signed commits cryptographically prove that a commit was made by the holder of a specific key. GitHub displays a **Verified** badge on signed commits. This guide walks through the full setup from zero — generating a GPG key, adding it to your GitHub profile, and configuring Git to sign commits automatically in the `data-platform` repository.

> **Note:** Hardware security keys such as YubiKey can store GPG keys and provide stronger tamper resistance. That pattern is not covered here — this guide covers software-based keys stored on your local machine.

---

## Windows Setup

### Step 1 — Install Gpg4win

Gpg4win is the standard GPG distribution for Windows. It includes the `gpg` command-line tool and Kleopatra (a certificate manager GUI).

1. Download from [gpg4win.org](https://gpg4win.org/download.html)
2. Run the installer — default component selection is fine (Kleopatra + GnuPG)
3. Verify installation by opening **Command Prompt** or **Git Bash** and running:

```bash
gpg --version
```

You should see `gpg (GnuPG) 2.x.x` or similar.

---

### Step 2 — Generate Your GPG Key (Windows)

Open **Command Prompt**, **PowerShell**, or **Git Bash** and run:

```bash
gpg --full-generate-key
```

Work through the prompts:

| Prompt         | What to select                                                                    |
| :------------- | :-------------------------------------------------------------------------------- |
| Key type       | `9` — ECC and ECC (Ed25519, modern and compact)                                   |
| Elliptic curve | `1` — Curve 25519                                                                 |
| Key expiry     | `1y` — 1 year (recommended; you can extend before it expires)                     |
| Confirm expiry | `y`                                                                               |
| Real name      | Your full name                                                                    |
| Email address  | **Must exactly match** your GitHub account email and your `git config user.email` |
| Comment        | Leave blank or enter a brief note (e.g., `data-platform`)                         |
| Confirm        | `O` to proceed                                                                    |
| Passphrase     | Enter a strong passphrase — this protects your key at rest                        |

> **Important:** The email address must match exactly. If your Git `user.email` and GitHub account email differ from what you enter here, GitHub will not associate the signature with your account.

GPG will generate your key and print output similar to:

```
pub   ed25519 2026-04-21 [SC] [expires: 2027-04-21]
      A1B2C3D4E5F6A7B8C9D0E1F2A3B4C5D6E7F8A9B0
uid                      Your Name <you@smiledoctors.com>
sub   cv25519 2026-04-21 [E] [expires: 2027-04-21]
```

Record the long hex string — this is your **key fingerprint**. You will need the last 16 characters (the **key ID**) for Git configuration.

---

### Step 3 — Configure Git to Find GPG (Windows)

Git for Windows needs to know where `gpg.exe` lives. Run the following in Git Bash or PowerShell:

```bash
# Find the gpg path
where gpg
```

Then set it in Git config (adjust path if your install location differs):

```bash
git config --global gpg.program "C:/Program Files (x86)/GnuPG/bin/gpg.exe"
```

> **Git Bash users:** If `where gpg` returns a path inside Git's own bundled tools rather than Gpg4win, use the full Gpg4win path explicitly as shown above to ensure you are using the correct installation.

---

### Step 4 — Enable Passphrase Caching (Windows)

By default, GPG will prompt for your passphrase on every commit. To cache it for the duration of your session, update the GPG agent configuration.

Open (or create) the file `%APPDATA%\gnupg\gpg-agent.conf` and add:

```
default-cache-ttl 28800
max-cache-ttl 28800
```

This caches your passphrase for 8 hours. Restart the agent:

```bash
gpgconf --kill gpg-agent
```

GPG will start a new agent automatically on the next operation.

---

## Mac Setup

### Step 1 — Install GPG and Pinentry (Mac)

[Homebrew](https://brew.sh) is required. If you do not have it, install it first.

```bash
brew install gnupg pinentry-mac
```

`pinentry-mac` provides a native macOS dialog for passphrase entry — without it, GPG may fail silently in GUI environments.

Verify:

```bash
gpg --version
```

---

### Step 2 — Configure the GPG Agent (Mac)

Before generating a key, configure the agent to use `pinentry-mac`.

Open or create `~/.gnupg/gpg-agent.conf` and add:

```
pinentry-program /opt/homebrew/bin/pinentry-mac
```

> **Intel Mac:** The path is `/usr/local/bin/pinentry-mac`. Confirm with `which pinentry-mac`.

Also ensure `~/.gnupg/gpg.conf` exists and contains:

```
use-agent
```

Restart the agent:

```bash
gpgconf --kill gpg-agent
```

---

### Step 3 — Generate Your GPG Key (Mac)

```bash
gpg --full-generate-key
```

Work through the prompts:

| Prompt | What to select |
| :--- | :--- |
| Key type | `9` — ECC and ECC (Ed25519) |
| Elliptic curve | `1` — Curve 25519 |
| Key expiry | `1y` — 1 year |
| Confirm expiry | `y` |
| Real name | Your full name |
| Email address | **Must exactly match** your GitHub account email and your `git config user.email` |
| Comment | Leave blank or enter a brief note |
| Confirm | `O` to proceed |
| Passphrase | Enter a strong passphrase via the macOS dialog that appears |

Your key fingerprint will be printed on completion — record it.

---

## Add Your Public Key to GitHub (All Platforms)

### Step 1 — Export Your Public Key

Find your key ID:

```bash
gpg --list-secret-keys --keyid-format=long
```

Output will look like:

```
sec   ed25519/A3B4C5D6E7F8A9B0 2026-04-21 [SC] [expires: 2027-04-21]
      A1B2C3D4E5F6A7B8C9D0E1F2A3B4C5D6E7F8A9B0
uid                 [ultimate] Your Name <you@smiledoctors.com>
```

The key ID is the portion after the `/` on the `sec` line — in this example, `A3B4C5D6E7F8A9B0`.

Export your public key:

```bash
gpg --armor --export A3B4C5D6E7F8A9B0
```

Copy the entire output, including the `-----BEGIN PGP PUBLIC KEY BLOCK-----` and `-----END PGP PUBLIC KEY BLOCK-----` lines.

### Step 2 — Add to GitHub Profile

1. GitHub → click your avatar → **Settings**
2. **SSH and GPG keys** → **New GPG key**
3. Give it a descriptive title (e.g., `Work MacBook 2026`)
4. Paste your public key block into the **Key** field
5. Click **Add GPG key**

GitHub will display your key fingerprint under GPG keys. The **Verified** badge will now appear on commits signed with this key.

---

## Configure Git Signing

### Repo-Specific (data-platform — recommended starting point)

Navigate to your local `data-platform` clone and run:

```bash
cd /path/to/data-platform

# Set your signing key for this repo
git config --local user.signingkey A3B4C5D6E7F8A9B0

# Enable automatic signing for all commits in this repo
git config --local commit.gpgsign true
```

This writes to `.git/config` inside the repo — it only affects `data-platform` and does not touch your global Git configuration.

Confirm the settings were applied:

```bash
git config --local --list | grep sign
```

Expected output:

```
user.signingkey=A3B4C5D6E7F8A9B0
commit.gpgsign=true
```

### Global (optional — signs commits in all repos)

If you want signing enabled everywhere, set it globally instead of (or in addition to) the local config:

```bash
git config --global user.signingkey A3B4C5D6E7F8A9B0
git config --global commit.gpgsign true
```

> Local config takes precedence over global config. If you set a different key per repo, the local setting wins.

---

## Verify a Signed Commit

Make a commit and confirm it is signed:

```bash
git log --show-signature -1
```

You should see output containing:

```
gpg: Signature made ...
gpg: Good signature from "Your Name <you@smiledoctors.com>"
```

On GitHub, the commit will show a **Verified** badge in the commit history.

---

## Troubleshooting

### `error: gpg failed to sign the data`

- **Windows:** Confirm `gpg.program` points to the Gpg4win `gpg.exe`, not a bundled Git version
- **Mac:** Confirm `pinentry-mac` is installed and referenced correctly in `gpg-agent.conf`; run `gpgconf --kill gpg-agent` and retry
- Run `echo "test" | gpg --clearsign` to test GPG independently of Git — this isolates whether the issue is GPG itself or the Git integration

### `No secret key` or key not found

Your `user.signingkey` in Git config must match the key ID shown in `gpg --list-secret-keys --keyid-format=long`. Confirm the value is set correctly with `git config --local --list`.

### GitHub shows "Unverified" despite signing

- The email on the GPG key must match the email on your GitHub account **and** your `git config user.email`
- Run `git config user.email` and `gpg --list-secret-keys` side by side to confirm they match
- Check GitHub → Settings → Emails — the address must be verified

### Key expired

Extend your key's expiry before it lapses:

```bash
gpg --edit-key A3B4C5D6E7F8A9B0
# At the gpg> prompt:
expire
# Follow prompts to set a new expiry, then:
save
```

Re-export and update your GitHub profile with the refreshed public key.

### Passphrase prompt not appearing (Mac)

Restart the GPG agent and confirm `pinentry-mac` is correctly referenced:

```bash
gpgconf --kill gpg-agent
gpg-agent --daemon
echo "test" | gpg --clearsign
```
