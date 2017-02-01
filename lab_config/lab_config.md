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
To work on a VM you'll have to clone an appropriate `_base` image.

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

#### Scripted
_TODO: Do the GUI steps from the terminal_

### Remote operation
_TODO: How (and why) to start VM in headless mode_

_TODO: How to send commands to the VM_

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
