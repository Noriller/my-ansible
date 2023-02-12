# My Ansible Playbook

This is my ansible solution to setup and configure a new computer.

## Start

I start with a Ubuntu 22.04 LTS "minimal" install.

Then:
```bash
sudo bash -c "$(wget -O - https://raw.github.com/Noriller/my-ansible/master/start.sh)"
```

Reboot after finishing.

## Things you might want to do before starting:

### Healthchecks (optional)

Create an account and have a UUID ready for it.

Create the account here:

[https://healthchecks.io/](https://healthchecks.io/)


This will send an email notification in case of failures.

### Telegram (optional)

Setup a telegram bot and have the chat_id and token ready.

This will send notifications in case of success or failure.

## Should I use this as is?

Probably not.

These are my options, and since I'm new to Linux in general, I believe I gonna change a lot of things to fit my needs.

Probably in a daily basis!

### What you can do is:

- Fire a VM, make a fresh install, and then run this.
- See if you like or not the results.
- Fork and change stuff as needed.
- ???
- Profit.

Also:

- do a `dconf dump / > your-dump.txt` on your Ubuntu
- do a `dconf dump / > my-dump.txt` on the VM after everything is installed
- `diff your-dump.txt my-dump.txt` to see the differences (I actually do this on VSCode and it's pretty easy to do)

Use that as a reference to see what you would need to change.

---

And hit me up if you have any questions, suggestions, or just want to say hi.

---

PS: Check out my post about it on Dev.to: [Automating my personal Ubuntu with Ansible](https://dev.to/noriller/automating-my-personal-ubuntu-with-ansible-25bh)
