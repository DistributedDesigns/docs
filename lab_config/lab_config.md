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

## Resources

### Port Assignments
- Inter machine communication: `444430` -> `444439`
- Quote server: `quoteserve.seng.uvic.ca:4443`

### Network Storage
Can do local installs for software here. Has a 2TB capacity.
- `/seng/seng462/group3`
  - Private but slow
- `/seng/scratch/group3`
  - _Not_ private
