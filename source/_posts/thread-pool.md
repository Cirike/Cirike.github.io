---
title: ThreadPoolExecutor线程池
date: 2020-01-03 10:31:33
categories:
- 计算机
- Java
tags:
- Java
- 多线程
- 线程池
- 并发
---

## ThreadPoolExecutor

*ThreadPoolExecutor*是**Executor**接口的实现类，用于构造一个线程池。

### **核心构造方法**

```java
public ThreadPoolExecutor(int corePoolSize,
                              int maximumPoolSize,
                              long keepAliveTime,
                              TimeUnit unit,
                              BlockingQueue<Runnable> workQueue,
                              ThreadFactory threadFactory,
                              RejectedExecutionHandler handler)
```

* `corePoolSize`

  该属性为线程池的核心线程数，线程池会维持至少拥有核心线程数的线程数目。

* `maximumPoolSize`

  该属性规定线程的最大数目，是线程池创建线程数目的上限，当线程数量不足以处理任务时，会将任务加入到等待队列。

* `keepAliveTime`

  线程存活时间，线程空闲超过存货时间便会自动销毁，该属性对核心线程无效。

* `unit`

  一个时间单位枚举类，用来规定keepAliveTime属性的时间单位。

* `workQueue`

  表示当任务数量过多线程不足以处理时任务挂起存放的队列。

* `threadFactory`

  线程工厂，为线程池创建线程。

* `handler`

  拒绝处理任务时的策略，`ThreadPoolExecutor`提供了四种可选方式：

  - **ThreadPoolExecutor.AbortPolicy**:丢弃任务并抛出`RejectedExecutionException`异常。
  -  **ThreadPoolExecutor.DiscardPolicy**:也是丢弃任务，但是不抛出异常。
  -  **ThreadPoolExecutor.DiscardOldestPolicy**:丢弃队列最前面的任务，然后重新尝试执行任务(重复此过程直除非线程池关闭)。
  - **ThreadPoolExecutor.CallerRunsPolicy**:由调用线程处理该任务，如果任务被拒绝了，则由调用线程（提交任务的线程）直接执行此任务。

  也可以通过实现`RejectedExecutionHandler`接口的方式自定义拒绝策略。

  通过调整参数可以构造出适应各种场景的线程池，JDK还提供了几种特定的预定义线程池。

### **预定义线程池**

​	预定义线程池可以通过JDK提供的`Executors`工具类的静态方法来创建。

 * **FixedThreadPool**

   ```java
   public static ExecutorService newFixedThreadPool(int nThreads) {
           return new ThreadPoolExecutor(nThreads, nThreads,
                                         0L, TimeUnit.MILLISECONDS,
                                         new LinkedBlockingQueue<Runnable>());
       }
   
   ```

   通过构造方法可以看出，FixedThreadPool的corePoolSize与maximumPoolSize相等，创建了一个线程数量不变的线程池。阻塞队列使用`LinkedBlockingQueue`，LinkedBlockingQueue是一个阻塞无边界队列，

 * **CachedThreadPool**

   ```java
   public static ExecutorService newCachedThreadPool() {
       return new ThreadPoolExecutor(0, Integer.MAX_VALUE,
                                     60L, TimeUnit.SECONDS,
                                     new SynchronousQueue<Runnable>());
   }
   
   ```

   该方法构造出一个核心线程数为`0`，但是最大线程数几乎无线的线程池，主要用于快速处理大量耗时短的任务。因此阻塞队列使用了`SynchronousQueue`,SynchronousQueue是一个没有容量的无缓存等待队列，会直接将任务交给消费者，必须等队列中的添加元素被消费后才能继续添加新的元素。

 * **SingleThreadExecutor**

   ```java
   public static ExecutorService newSingleThreadExecutor() {
           return new FinalizableDelegatedExecutorService
               (new ThreadPoolExecutor(1, 1,
                                       0L, TimeUnit.MILLISECONDS,
                                       new LinkedBlockingQueue<Runnable>()));
   }
   
   ```

   该方法构建出一个单核线程的线程池，线程池只有一个线程，而且使用`new FinalizableDelegatedExecutorService()`包裹，使得该线程池无法通过向下转型为`ThreadPoolExecutor`之后使用`setCorePoolSize()`方法的方式修改线程数目。

### **其它**

![Executor接口继承关系](https://cdn.jsdelivr.net/gh/Cirike/cdn.static.resource@master/blog_img/20200103104627.png)

**Executor**接口继承关系下还有一个`ScheduledExecutorService`接口，该接口提供了一种给定时间延迟后运行或者定期执行任务方式的线程池，这个留到以后再说。

