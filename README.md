Reports and other dev notes
=====

### Contents
- [Lab config](#lab-config)
  - [Port Assignments](#port-assignments)
  - [Network Storage](#network-storage)
- [Business Logic](#business-logic)
  - [Triggers](#triggers)

## Lab Config
Resources allocated / accessible in the B203 lab.

### Port Assignments
- Inter machine communication: `444430` -> `444439`
- Quote server: `quoteserve.seng.uvic.ca:4443`

### Network Storage
Can do local installs for software here. Has a 2TB capacity.
- `/seng/seng462/group3`
  - Private but slow
- `/seng/scratch/group3`
  - _Not_ private

## Business Logic
Clarifies ambiguous situations in the [user command document][command_doc].

#### Triggers
**Multiple triggers for same stock same account**

Overwrite any pre-existing buys or sells
```
user triggers:
  XYZ:
    buy_amount: 100
    buy_trigger: 200
  ABC:
    buy_amount: 150
    buy_trigger: 250

send: SET_BUY_TRIGGER,user,XYZ,30

user triggers:
  XYZ:
    buy_amount: 100
    buy_trigger: 30
  ABC:
    buy_amount: 150
    buy_trigger: 250
```

**Incomplete triggers**

Both TRIGGER and AMOUNT must be set for trigger to execute
```
user triggers:
  XYZ:
    buy_amount: 100
    # no buy trigger

<< XYZ gets quote update and triggers for XYZ are checked >>

- No buys execute for user on XYZ
```

```
user triggers:
  XYZ:
    # no buy amount
    buy_trigger: 200

<< XYZ gets quote update and triggers for XYZ are checked >>

- No buys execute for user on XYZ
```

**Removing triggers**

Only remove the TRIGGER, keep the AMOUNT
```
user triggers:
  XYZ:
    buy_amount: 100
    buy_trigger: 200

send: CANCEL_SET_BUY,user,XYZ

user triggers:
  XYZ:
    buy_amount: 100
    # no buy trigger
```

[command_doc]: http://www.ece.uvic.ca/~seng462/ProjectWebSite/Commands.html
