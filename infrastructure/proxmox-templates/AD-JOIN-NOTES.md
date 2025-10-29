# Active Directory Domain Join - Template Approach

## Problem

When an AD-joined system is converted to a template and cloned, all clones share the same:
- Computer account in Active Directory
- Kerberos keytab (`/etc/krb5.keytab`)
- SSSD cache
- Machine identity

This causes **Kerberos preauthentication failures** because AD detects multiple systems trying to use the same computer account.

## Solution Implemented

The playbook now uses a **"join-test-leave-rejoin"** approach:

### 1. **During Template Build** (rocky-cis-template.yml)
- Configure all AD settings (DNS, Kerberos, SSSD)
- Perform a test join to validate configuration
- **Leave the domain** before templating
- Clean all AD/Kerberos artifacts:
  - `/etc/krb5.keytab`
  - `/var/lib/sss/db/*`
  - `/var/lib/sss/mc/*`
  - Kerberos credential caches
- Install a first-boot service: `firstboot-ad-join.service`

### 2. **On First Boot of Cloned VM**
The `firstboot-ad-join.service` automatically:
- Waits for network connectivity
- Obtains Kerberos ticket using admin credentials
- Joins the domain with the clone's **unique hostname**
- Creates a unique computer account in AD
- Marks itself as complete (`/var/lib/firstboot-ad-joined`)
- Never runs again

## Files Created

### `/usr/local/sbin/firstboot-ad-join.sh`
Bash script that performs the actual domain join with proper error handling and logging.

**Log file:** `/var/log/firstboot-ad-join.log`

### `/etc/systemd/system/firstboot-ad-join.service`
Systemd oneshot service that runs after network is online.

**Condition:** Only runs if `/var/lib/firstboot-ad-joined` doesn't exist

## Verification

After cloning a VM from the template:

1. **Check service status:**
   ```bash
   systemctl status firstboot-ad-join.service
   ```

2. **Check join log:**
   ```bash
   cat /var/log/firstboot-ad-join.log
   ```

3. **Verify domain membership:**
   ```bash
   realm list
   id username@saguaroscyberhub.org
   ```

4. **Check AD computer account:**
   In AD Users and Computers, verify unique computer object was created.

## Security Notes

⚠️ **WARNING:** The join script contains cleartext AD admin credentials for automation.

**For Production:**
- Use a dedicated service account with limited privileges
- Store credentials in Ansible Vault or secrets management
- Consider using one-time passwords or managed service identities
- Restrict the service account to only create computer objects in specific OUs

## Troubleshooting

### Service failed to join domain
Check the log file for specific errors:
```bash
journalctl -u firstboot-ad-join.service
cat /var/log/firstboot-ad-join.log
```

### Network not ready
Increase the wait loop in `/usr/local/sbin/firstboot-ad-join.sh` (currently 30 retries × 2 seconds)

### Wrong computer OU
Verify `ad_computer_ou` variable in `configs/rocky-cis-test-vars.yml`

### Duplicate computer account
If the service ran but failed, manually remove the stale computer object in AD before retrying:
```bash
rm -f /var/lib/firstboot-ad-joined
systemctl restart firstboot-ad-join.service
```

## Manual Join Process

If you prefer to join manually after cloning:

1. Disable the service:
   ```bash
   systemctl disable firstboot-ad-join.service
   ```

2. Join manually:
   ```bash
   echo 'password' | kinit Administrator@SAGUAROSCYBERHUB.ORG
   realm join saguaroscyberhub.org
   ```
