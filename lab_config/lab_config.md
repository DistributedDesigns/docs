Lab Config
=====
Resources allocated / accessible in the B203 lab.

## Go Setup

### Installing Go Locally
Grab a local copy of the Go compiler
```shell
mkdir -p $HOME/local/go1.7.4
cp /seng/seng462/group3/local/go1.7.4/* $HOME/local/go1.7.4/
```

Set up your workspace
```shell
mkdir $HOME/go
```

Export the workspace. Add this to your `.bashrc`
```shell
GOROOT=$HOME/local/go1.7.4
GOPATH=$HOME/go

export GOROOT
export GOPATH

PATH=$PATH:$GOROOT/bin
export PATH
```

Make a test file `hello.go`
```shell
mkdir -p $GOPATH/src/github.com/YOUR_GH/hello
touch $GOPATH/src/github.com/YOUR_GH/hello/hello.go
```
```go
package main

import "fmt"

func main() {
  fmt.Println("Hello world!")
}
```

Compile, install and run
```shell
go install github.com/YOUR_GH/hello
$GOPATH/bin/hello
```

## VMs
We'll (eventually) be deploying this to the lab inside a VM with docker. Workflow is to clone a pre-configured VM and do all work inside the clone. This creates a standard deployment environment. The master VM is a minimal installation of CentOS with networking, Vim and Docker installed.

### Local VMs
To work on a VM you'll have to clone an appropriate base image. The **`base_with_batteries`** image is the current master. It includes:
- Permissive networking
- Vim
- Docker 1.12.5
- git 1.8.3.1
- golang 1.7.4 (`$GOPATH` = `/go`)
- redis-cli 3.2

The login:pass is `root:seng462`.

#### GUI
0. Go to `/seng/seng462/group3/VMs/`
0. Open `./${VM_base}/${VM_base}.vbox`. VirtualBox Manager will open.
0. On the base image: Right-click > Clone
  - Rename the machine, `Next >`
  - Choose "Full clone", `Clone`
  - New VM lives at `$YOUR_VB_HOME/${whatever you called the clone}`
0. Remove the base image from VirtualBox Manager
  - Right click > Remove > **Remove only**
0. (Optional) Move the image to the local machine. This is good for performance but not portability.
  1. On cloned VM: Right-click > Remove > Remove only
  1. Copy `$YOUR_VB_HOME/${whatever you called the clone}` to `/seng/scratch/group3`
  1. Open the migrated `.vbox` file.

#### CLI
```sh
# Log in to the machine where the VM will run
ssh netlinkID@bXXX.seng.uvic.ca

# Check if a base VM is present
VBoxManage list vms

# (Optional) Register (not copy) the base image if it's not present
VBoxManage registervm /seng/seng462/group3/VMs/${BASE_VM}/${BASE_VM}.vbox

# Clone the base to the local machine
VBoxManage clonevm ${BASE_VM} --name ${VM_NAME} --basefolder /seng/scratch/group3 --register

# Default is for SSH only on localhost; we want it available over the network
# Standard SSH port is 44439
VBoxManage modifyvm ${VM_NAME} --natpf1 delete ssh
VBoxManage modifyvm ${VM_NAME} --natpf1 "ssh,tcp,142.104.91.${MACHINE},${SSH_PORT},,22"

# Set up RMQ while we're at it
# Standard RMQ port is 44430
VBoxManage modifyvm ${VM_NAME} --natpf1 "RMQ,tcp,142.104.91.${MACHINE},${RMQ_PORT},,${RMQ_PORT}"
# Expose any other ports you want

# Start the VM
VBoxManage startvm ${VM_NAME} --type headless

# After ~5sec you can SSH into the VM
ssh -p ${SSH_PORT} root@b${MACHINE}.seng.uvic.ca
```

VM setup is automated with [this script][gist-vm-setup].

### Remote operation
1. [Sending workloads into redis for multiple workers][gist-redis-loader]

## Resources

### Port Assignments
- Inter machine communication: `444430` -> `444439`
- Quote server: `quoteserve.seng.uvic.ca:4443`

### Network Storage
Can do local installs for software here. Has a 2TB capacity.
- `/seng/seng462/group3`
  - Private network storage. Installers, VM masters live here.
- `/seng/scratch/group3`
  - The physical disk of the machine you're logged in to.
  - If you're logged in to B142 then you can't see `/seng/scratch/group3` on B143
  - Install location for VMs.

[gist-vm-setup]: https://gist.github.com/trstephen/3705f3b99c43c2df58ab0e646c86019c
[gist-redis-loader]: https://gist.github.com/trstephen/77f3d7ae6a6d41e1839b0e33f9fefb32
