Project Plan
===

We constructed a monolithic application to run the initial 1 user, 1 stock, 100 transaction file. The intention of the development was to expose group members to Go and field-test the transaction design provided by Day Trading Inc. The application successfully completed the single user workload. Performance was not a design goal for this application.

In the interest of stress testing a known poor design, the monolith processed the 10 user workload. It achieved slightly more than 5.1 transactions per second. All further development will be towards the final distributed application.

## Timeline

| Period | Activities | Deadlines |
|---|---|
|01-30| Build message queue prototypes with RMQ and 0MQ. Write helper packages (logger, workload generator, currency, data types). |none|
|02-06| Start worker implementation (state machine, quote cache, user accounts, buy/sell). Write Quote Manager, Audit Server. Implement message bus. |~~10 users~~|
|02-13| (Reading break) Automate installation in lab environment. Implement auto transactions on worker and manager. |none|
|02-20| Add system profiling and reporting. |45 users|
|02-27| Tune performance. |100 users|
|03-06| Tune performance. |1000 users|
|03-13| Start FE implementation. |none|
|03-20| Add security protection. Shift deploy to Docker containers. |none|
|03-27| Finish FE. |none|
|04-03| Write report and presentation. |1250 users, web interface|
