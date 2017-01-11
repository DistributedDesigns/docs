Reports and other dev notes
=====

### Contents
  - [Business Logic](#business-logic)
    - [Triggers](#triggers)

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
