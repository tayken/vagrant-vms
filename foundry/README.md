# Foundry VTT VM

A Vagrant VM that automatically sets up Foundry VTT upon provisioning.

## Usage

### Provisioning

In order to provision this VM, you'll need the timed URL of the Foundry VTT
package. Go to your "Purchased Licenses" page, select any version of Foundry,
then select "Node.js" as your operating system and click the "Timed URL" button.
The link will be copied to your clipboard and will be valid for 300 seconds.
Finally provision the VM with:

```bash
FOUNDRY_URL="<timed_url>" vagrant up
```

Once provisioned, you can manage the machine without the `FOUNDRY_URL`
environment variable. Just `vagrant up` and `vagrant halt` is enough.

### Managing Backups

If you need to migrate from one machine to another or if you just need to back
up your snapshots, worlds, modules, systems, assets etc., you can use the
`manage.sh` script. Just source it with `. manage.sh`. Then you can create your
backups, then copy them from your VM to your host machine with `backup_data`.
You can restore your backups with `restore_data`.
