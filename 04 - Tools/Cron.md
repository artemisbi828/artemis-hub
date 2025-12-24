Used in Google Cloud Scheduler

| **Position**     | **Value** | **Meaning**                                      |
| ---------------- | --------- | ------------------------------------------------ |
| **Minute**       | `0`       | Run exactly at the start of the hour (minute 0). |
| **Hour**         | `20`      | Run at 8 p.m. (24-hour format, hour 20).         |
| **Day of Month** | `*`       | Run every day of the month.                      |
| **Month**        | `*`       | Run every month.                                 |
| **Day of Week**  | `1-5`     | Run Monday (1) through Friday (5).               |
replace 20 (8PM) w 8 (8AM)