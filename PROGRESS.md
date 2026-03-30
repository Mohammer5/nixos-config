Plan

1. Install or confirm the VM tooling on your host.
   What you do:

- Decide whether you want virt-manager installed system-wide or just available ad hoc.
- Confirm virtualization is enabled in BIOS/UEFI if you have never used VMs before.

What I could do for you:

- Inspect this NixOS config and tell you whether libvirt, qemu, and virt-manager are already enabled.
- Add the necessary NixOS configuration for a standard virt-manager setup if you want me to edit your config.
- Tell you exactly which rebuild command to run after that.

2. Create a clean NixOS guest VM.
   What you do:

- Download the NixOS ISO.
- In virt-manager, create a new VM from that ISO.
- Give it modest resources: 2 vCPU, 4-8 GB RAM, 30 GB disk.
- Use the default NAT network, not bridged networking.

What I could do for you:

- Give you the exact virt-manager settings to click through.
- Recommend a sane VM profile based on your hardware.
- If you prefer, prepare a NixOS guest configuration you can apply after install.

3. Keep the VM isolated from your host.
   What you do:

- Do not enable shared folders.
- Do not pass through your SSH keys, GPG keys, browser profile, password manager data, or host directories.
- Keep networking on default NAT only.
- Avoid clipboard sharing if you can tolerate it.

What I could do for you:

- Give you a short hardening checklist for virt-manager so you can verify you did not accidentally expose anything.
- Review screenshots or pasted config details and tell you whether the VM boundary looks clean.

4. Install NixOS in the VM with a minimal setup.
   What you do:

- Boot the ISO.
- Install a basic NixOS system with a normal unprivileged user.
- Enable only what you need for testing openclaw.

What I could do for you:

- Provide a minimal guest configuration.nix tuned for this use case.
- Keep it intentionally simple: desktop optional, basic network, no extra services unless needed.

5. Snapshot the VM before installing openclaw.
   What you do:

- Once the OS is installed and updated, create a clean snapshot in virt-manager.
- Treat that snapshot as your rollback point.

What I could do for you:

- Tell you exactly when to snapshot and what to name the checkpoints.
- Suggest a small snapshot strategy like clean-install and pre-openclaw.

6. Use throwaway credentials and fake data only.
   What you do:

- Create restricted test API keys if openclaw needs them.
- Use dummy repos, test accounts, and non-sensitive data.
- Assume the VM may be burned after testing.

What I could do for you:

- Help you scope the minimum permissions those test credentials should have.
- Review an env file or compose file and point out anything overly permissive.

7. Install and run openclaw inside the VM only.
   What you do:

- Perform the full install from inside the guest.
- Expose only the ports you explicitly need for local testing.
- Access it through the VM’s NAT address or port forwarding if required.

What I could do for you:

- Walk you through the install instructions once you have the VM ready.
- Review the openclaw deployment method and flag risky parts like Docker socket mounts, host mounts, or privileged containers.

8. Reset aggressively while experimenting.
   What you do:

- Revert to snapshot whenever you are done testing or if the setup gets messy.
- Delete and recreate the VM if you stop trusting its state.

What I could do for you:

- Give you a lightweight “safe test workflow” so each session starts from a clean snapshot.

What I recommend next

The immediate next step is to check whether your host already has the required virtualization pieces enabled. If you want, I can do that inspection and then either:

1. tell you what is already in place, or
2. patch your NixOS config to enable virt-manager/libvirt with the minimum required settings.
