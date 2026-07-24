# Taskwarrior 

<img src="../../../14-assets/images/taskwarrior.png" width="40"> https://taskwarrior.org/

Taskwarrior is a powerful command-line task management tool that helps users organize, prioritize, schedule, and track personal and professional tasks using a flexible, scriptable, and text-based workflow.


## ACTIVE filter

With `+ACTIVE` filter you can simply list the "started" tasks.

```
%> task +ACTIVE

ID Active Age  P Project Tag            Due  Description                                                                Urg 
44   2d   2w   H customer  demo qsr visit 6d   Prepare ACM demo, slides and script (documentation)                        18.8
                                               2024-08-27 Base demo deployed and cluster lifecycle management practiced     
43   2d   2w   H customer  qsr visit      7d   Prepare TAM Service Review Slides 2024                              18.3
                                               2024-08-27 First beta version prepared                                    
                                               2024-08-29 Reviewed, i have to add some extra per VAT request             

2 tasks
Context 'work' set. Use 'task context none' to remove.
```

* I must start/stop working on tasks (discipline).
* I must not have a large of active tasks, that hurts focus.

But how can i know what's the next important for to start working on?
There are so many things important to i must do!

Lets try.

 We can query projects non-active tasks:

```
%> task project:customer

ID Active Age   P Project Tag            Due   Description                                                                Urg 
44   2d    2w   H customer  demo qsr visit  6d   Prepare ACM demo, slides and script (documentation)                        18.8
                                                 2024-08-27 Base demo deployed and cluster lifecycle management practiced     
43   2d    2w   H customer  qsr visit       7d   Prepare TAM Service Review Slides customer 2024                              18.3
                                                 2024-08-27 First beta version prepared                                       
                                                 2024-08-29 Reviewed, i have to add some extra per VAT request                
62        19h   H customer  qsr visit      11d   Prepare ACM Sales Slides                                                   11.5
 2         8w   L customer  visit           4mo  Customer Visit Setup (2nd)                                                 7.21
                                                 2024-07-17 Thinking year ending                                              
                                                 2024-08-05 Evaluating to focus on one only meeting                           
11         6w     customer  tsr             2w   Phased Gates plan                                                          4.45

5 tasks
```

But you have several accounts and your personal project for PD and related tasks, let's try using due dates:

```
%> task due:friday next

ID Active Age   P Project      Tag       Recur Due  Description                                                     Urg 
43   2d    2w   H customer       qsr visit       7d   Prepare TAM Service Review Slides customer 2024                   18.3
                                                      2024-08-27 First beta version prepared                            
                                                      2024-08-29 Reviewed, i have to add some extra per VAT request     
61        19h   H customer2    kickoff         7d   Kickoff TAM OpenShift Service Presentation                      13.3
64        46min   tam-practice             P7D 6d   Update engagement plan                                          6.78

3 tasks
```

That is better, disclaimer, the result do not include recurrent tasks.