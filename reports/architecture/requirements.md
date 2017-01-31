Requirements
===

## Project Overview
The goal of the system is to emulate a stock market daytrading system. The actions it must accomplish are detailed under the initial requirements section. The project will be completed using golang, ZeroMQ, and most likely JavaScript for the frontend client. These architectural design decisions are detailed under the architecture section.


## Initial Requirements
The project must support at minimum the following commands:
- Add: Add the given amount of money to the user's account
- Quote: Get the current quote for the stock for the specified user
- Buy: Buy the dollar amount of the stock for the specified user at the current price.
- Commit Buy: Commit the most recently executed BUY command.
- Cancel Buy: Cancels the most recently executed BUY command.
- Sell: Sell the specified dollar amount of the stock currently held by the specified user at the current price.
- Commit Sell: Commit the most recently executed SELL command.
- Cancel Sell: The user must have executed a SELL command within the previous 60 seconds.
- Set Buy Amount: Set a defined amount of the given stock to buy when the current stock price is less than or equal to the Buy Trigger.
- Cancel Set Buy: Cancels a Set Buy command issued for the given stock.
- Set Buy Trigger: Sets the trigger point base on the current stock price when any set buy will execute.
- Set sell amount: Set the defined amount of the specified stock to sell when the current stock price is equal or greater than the sell trigger point.
- Set Sell Trigger: Sets the stock price trigger point for executing any set sell triggers associated with the given stock and user.
- Cancel Set Sell: Cancels the set sell associated with the given stock and user.
- Dumplog: Print out the history of the user's transaction to the user specified file.
- Display Summary: Provide a summary to the client of the given user's transaction history and the current status of their accounts as well as any set buy or sell triggers and their parameters.

Additionally, the system must support a minimum of 1000 users.

Finally, the system must have a frontend client which allows the user to navigate the system.
