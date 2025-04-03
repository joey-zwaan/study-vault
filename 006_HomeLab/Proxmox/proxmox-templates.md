# Creating Ubuntu and Debian OS Template on Proxmox VE

---

## Introduction

In any virtualization platform, an OS template is a pre-configured operating system image that you can use to deploy a Virtual Machine. Templates enable you to create single or multiple Virtual Machine instances in seconds. It is always recommended to create a special template with all necessary configurations instead of cloning an existing Virtual Machine with application data, as it provides a clean state.

Proxmox Virtualization Environment is bundled with container-based templates. Additionally, you can create and deploy KVM templates as of the V3.x series releases. This guide covers a step-by-step process for creating Ubuntu or Debian Linux operating system templates. A similar procedure can be applied to other Linux distributions.

For CentOS / Rocky / AlmaLinux, refer to [Creating Rocky / AlmaLinux / CentOS OS Templates on Proxmox VE](#).

---


## Step 1: Create VM on Proxmox VE

1. Log in to your Proxmox VE environment and begin VM creation by right-clicking on the hypervisor name → **Create VM**.
2. **VM Name**: Provide a name for the VM and optionally set a VM ID. A higher number for the ID is better to avoid conflicts with other instances.
3. **OS**: Under the "OS" section, select **Do not use any media**.
4. **System**: Under "System", check **Qemu Agent**. The default settings should work fine.
5. **Disks**: On the "Disks" screen, delete the auto-added SCSI disk 0. Confirm the deletion when prompted. You should see the message **No Disks**, which is expected.
6. **Set CPU cores**: Configure the number of CPU cores for the VM instance.
7. **Memory**: Set the memory for the instance (value is in MiB).
8. **Network**: Under "Network", select the Bridge name and uncheck the firewall option.
9. Click **Finish** to complete the VM creation process.

---

## Step 2: Attach Cloud-init Disk

Cloud-init handles the early initialization of the virtual machine instance before it boots from the disk. It is used for configuring user accounts, networking, SSH keys, etc.

1. Right-click on the VM name → **Hardware** → **Add** → **CloudInit Drive**.
2. Choose the storage to use for the image.
3. Confirm that the CloudInit Drive is added in the VM's hardware section.
4. Customize each variable in the Cloud-init configurations section as needed. For example, provide a default password for the default user account.
5. Use DHCP for networking to avoid manual IP address changes. Alternatively, you can use a MAC-based DHCP service.

---

## Step 3: Download OS Images for KVM

Download, customize, and create a disk from the default OS distribution cloud image.

### Ubuntu Linux OS Images

- **Ubuntu 22.04**:  
   ```bash
   wget https://cloud-images.ubuntu.com/releases/jammy/release/ubuntu-22.04-server-cloudimg-amd64.img
   ```

- **Ubuntu 20.04**:  
   ```bash
   wget https://cloud-images.ubuntu.com/releases/focal/release/ubuntu-20.04-server-cloudimg-amd64.img
   ```

- **Ubuntu 18.04**:  
   ```bash
   wget https://cloud-images.ubuntu.com/releases/bionic/release/ubuntu-18.04-server-cloudimg-amd64.img
   ```

### Debian Linux OS Images

- **Debian 12**:  
   ```bash
   wget https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-generic-amd64.qcow2
   ```

- **Debian 11**:  
   ```bash
   wget https://cloud.debian.org/images/cloud/bullseye/latest/debian-11-generic-amd64.qcow2
   ```

### Rename and Resize the Cloud Images

For Ubuntu, rename the cloud images with the `.qcow2` extension:

- **Ubuntu 22.04**:  
   ```bash
   mv ubuntu-22.04-server-cloudimg-amd64.img ubuntu-22.04-server-cloudimg-amd64.qcow2
   ```

Resize the disk size for the VM to a suitable default size:

- Example for Ubuntu 22.04:  
   ```bash
   qemu-img resize ubuntu-22.04-server-cloudimg-amd64.qcow2 20G
   ```

Enable the console for the virtual machine:

```bash
qm set <vm_id> --serial0 socket --vga serial0
```

---

## Step 4: Import Created Disk into VM Default Boot Disk

To import the disk into a Virtual Machine:

```bash
qm importdisk <vm_id> <image> <storage_name>
```

To list instances and storage domains in your Proxmox server:

```bash
qm list
pvesm status
```

### Example

For a VM with ID `777`:

```bash
qm importdisk 777 ubuntu-22.04-server-cloudimg-amd64.qcow2 local
```

After importing the image, the disk will remain unused. Attach it to the VM by navigating to the **Hardware** section of the VM.

---

## Step 5: Prepare VM for Templating

1. Access the VM console and log in with the username and password provided in the Cloud-init parameters.
2. Update and upgrade the OS:
   ```bash
   sudo apt update && sudo apt upgrade -y
   ```
3. Install the QEMU guest agent:
   ```bash
   sudo apt install qemu-guest-agent
   ```
4. Enable the guest agent to start at boot:
   ```bash
   sudo systemctl enable qemu-guest-agent
   ```
5. Reset the machine ID:
   ```bash
   sudo truncate -s 0 /etc/machine-id
   sudo rm /var/lib/dbus/machine-id
   ```
6. Run the Cloud-init cleaning script:
   ```bash
   cloud-init clean
   ```
7. Shutdown the instance:
   ```bash
   shutdown -h now
   ```

---

## Step 6: Create Virtual Machine from Template

To create a VM from the template, right-click the template and choose **Clone**. There are two standard cloning modes:

1. **Linked Clone**:  
   - Requires less disk space but cannot run without access to the base VM template.

2. **Full Clone**:  
   - A fully independent copy of the template but requires the same disk space as the original.

### Steps

1. Select the cloning mode (Full or Linked).
2. Choose the target storage for the VM instance and give it a name.
3. Modify hardware settings if needed, including Cloud-init configurations.
4. Start the instance. It should be up and running in a few seconds.

---

bron :
1 : [Proxmox templates for Debian & Ubuntu](https://computingforgeeks.com/creating-ubuntu-and-debian-os-template-on-proxmox-ve/)
2 : [Reset machine-id on Linux](https://syncbricks.com/how-to-reset-the-machine-id-on-an-ubuntu-server)


---