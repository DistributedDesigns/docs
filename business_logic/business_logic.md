Business Logic
=====

Clarifies ambiguous situations in the [user command document][command_doc].s

### BUY
**BUY needs a fresh quote from a user**

Quotes expire in 60s
```
[1] ADD,userA,100     << Initialize user
[2] BUY,userA,XYZ,50  << Fails because user did not QUOTE for XYZ
[3] QUOTE,userA,XYZ   

 > 60s pass

[4] BUY,userA,XYZ,50  << Fails because Quote in 3 is stale
```

Can't reuse quotes from other users
```
[1] ADD,userA,100
[2] QUOTE,userB,XYZ
[3] BUY,userA,XYZ,200 << Fails because no quote from userA
```

**Users cannot buy fractional stocks**

Users can buy `(buy_amount % stock_price)` number of stocks.
```
[1] ADD,userA,100
[2] QUOTE,userA,XYZ   << XYZ = $15
[3] BUY,userA,XYZ,10  << Fails because user can't buy 0 stocks
```

**Only reserve amount necessary to buy whole stocks**
```
[1] ADD,userA,100
[2] QUOTE,userA,XYZ   << XYZ = $15
[3] BUY,userA,XYZ,50  << $45 removed from userA and placed in reserve
```

### Triggers
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
