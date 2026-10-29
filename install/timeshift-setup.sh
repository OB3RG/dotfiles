#!/usr/bin/env bash
# Configure Timeshift for BTRFS snapshots and take the first one.
# Schedule: daily (keep 7) + weekly (keep 4). Home is excluded on purpose —
# snapshots are for rolling back the system, not your data.
#
# Run as root: sudo ./install/timeshift-setup.sh
set -euo pipefail

if [ "$(id -u)" -ne 0 ]; then
  echo "Run this with sudo." >&2
  exit 1
fi

# Device backing / (strip the BTRFS [/@subvol] suffix); works for both
# plain partitions and the /dev/mapper/cryptroot of a LUKS install.
ROOT_DEV="$(findmnt -n -o SOURCE / | sed 's/\[.*\]//')"
UUID="$(blkid -s UUID -o value "$ROOT_DEV")"

mkdir -p /etc/timeshift
cat > /etc/timeshift/timeshift.json <<EOF
{
  "backup_device_uuid" : "$UUID",
  "parent_device_uuid" : "",
  "do_first_run" : "false",
  "btrfs_mode" : "true",
  "include_btrfs_home_for_backup" : "false",
  "include_btrfs_home_for_restore" : "false",
  "stop_cron_emails" : "true",
  "schedule_monthly" : "false",
  "schedule_weekly" : "true",
  "schedule_daily" : "true",
  "schedule_hourly" : "false",
  "schedule_boot" : "false",
  "count_monthly" : "2",
  "count_weekly" : "4",
  "count_daily" : "7",
  "count_hourly" : "6",
  "count_boot" : "5",
  "snapshot_size" : "0",
  "snapshot_count" : "0",
  "date_format" : "%Y-%m-%d %H:%M:%S",
  "exclude" : [],
  "exclude-apps" : []
}
EOF

echo "Timeshift configured (BTRFS on $ROOT_DEV, UUID $UUID)."
echo "Schedule: daily x7, weekly x4 — cronie runs 'timeshift --check' hourly."

echo "Taking the first snapshot..."
timeshift --create --comments "Fresh install"
