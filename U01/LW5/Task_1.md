# Task 1

```sql
set autotrace off;
set autotrace on;
set autotrace traceonly;

set autotrace on explain;
set autotrace on statistics;
set autotrace on explain statistics;

set autotrace traceonly explain;
set autotrace traceonly statistics;
set autotrace traceonly explain statistics;

set autotrace off explain;
set autotrace off statistics;
set autotrace off explain statistics;
```
| Auto Trace Configuration Options           | Expected Results                                                                    |
| ------------------------------------------ | ----------------------------------------------------------------------------------- |
| set autotrace off                          | Autotrace Disabled                                                                  |
| set autotrace on                           | Autotrace Enabled. Shows the execution plan as well as statistics of the statement. |
| set autotrace traceonly                    | Autotrace TraceOnly.  Exhibits the performance statistics with silent query output  |
|                                            |                                                                                     |
| set autotrace on explain                   | Autotrace Enabled. Displays the execution plan only.                                |
| set autotrace on statistics                | Autotrace Enabled. Displays the statistics only.                                    |
| set autotrace on explain statistics        | Autotrace Enabled. Shows the execution plan as well as statistics of the statement. |
|                                            |                                                                                     |
| set autotrace traceonly explain            | Autotrace TraceOnly.  Exhibits the performance statistics with silent query output  |
| set autotrace traceonly statistics         | Autotrace TraceOnly.  Exhibits the performance statistics with silent query output  |
| set autotrace traceonly explain statistics | Autotrace TraceOnly.  Exhibits the performance statistics with silent query output  |
|                                            |                                                                                     |
| set autotrace off explain                  | Unwanted extra Autotrace option: explain                                            |
| set autotrace off statistics               | Unwanted extra Autotrace option: statistics                                         |
| set autotrace off explain statistics       | Unwanted extra Autotrace option: statistics                                         |