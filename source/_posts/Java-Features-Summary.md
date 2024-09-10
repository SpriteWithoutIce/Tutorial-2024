---
title: Java Features Summary
date: 2023-08-16 13:23:35
tags:
---


# Java 8 - 17 新特性总结

> 本文包含了 Java 8 至 Java 17 中各个版本引入的主要新特性，供大家参考。😋
>
> 往年总结：
>
> - [2022：Java 8 - 17 语法新特性总结](https://ryouonritsu.github.io/Java-HomeWork/docs/Resource/Java8-17%E8%AF%AD%E6%B3%95%E6%96%B0%E7%89%B9%E6%80%A7%E6%80%BB%E7%BB%93/)
>
> 参考文章：
>
> - [Java – How-Tos and Tutorials](https://www.happycoders.eu/java/)（相对更全面细致🤩）
> - [Java Features from Java 8 to Java 17](https://reflectoring.io/java-release-notes/)（范例很好😍）
> - [JDK 8 - JDK 17 新特性总结](https://juejin.cn/post/7250734439709048869)（部分时间线错乱😵‍💫）
>
> *本文中的代码大多来自以上文章。*

!!! Note
    带 `*` 的特性表示该特性已在更早的 Java 版本中引入，但是在该版本中进行了改进。

!!! Info
    有关 Java 和 JDK 版本号的问题，可以参考这篇文章：[Java 版本和 JDK 版本](https://cloud.tencent.com/developer/article/2128820)。（省流：Java 8 = JDK 1.8 = JDK 8。🫢）
    本文统一使用 Java X 指代各个版本。

---

# 1. Java 8

## 1.1 Lambda 表达式和 Stream API

!!! info Docs
    [Lambda Expressions](https://docs.oracle.com/javase/tutorial/java/javaOO/lambdaexpressions.html)

Lambda 表达式的基本语法如下，其对应一个函数式接口（即只有一个方法的接口）。

```java
(param1, param2, ...) -> expression 或
(param1, param2, ...) -> { statements; }
```

Stream API 用于处理集合和数组等数据源的元素序列，提供了一种流式操作的方式，可以用于对数据进行过滤、映射、排序、聚合等各种操作，从而更加方便和高效地处理数据。结合 Stream API 与 Lambda 表达式，代码可以变得更加简洁易懂。

在 Java 8 之前，如果我们想过滤列表中的数据，我们只能这样做：

```java
public class LambdaExpressions {
    public static List<Car> findCarsOldWay(List<Car> cars) {
        List<Car> selectedCars = new ArrayList<>();
        for (Car car : cars) {
            if (car.kilometers < 50000) {
                selectedCars.add(car);
            }
        }
        return selectedCars;
    }
}
```

使用 Lambda 表达式和 Stream API 后，Java 能够更轻松地实现函数式编程，简化代码的编写。

```java
public class LambdaExpressions {
    public static List<Car> findCarsUsingLambda(List<Car> cars) {
        return cars.stream()
            .filter(car -> car.kilometers < 50000)
            .collect(Collectors.toList());
    }
}
```

!!! Note
    Java 8 中还提供了一些通用的函数式接口，如 `Consumer<T>`，`Supplier<T>` 等，更多内容可参考以下文章：
    

    - [Java 8's Consumer, Predicate and Supplier Functional Interfaces](https://shivaprasadgurram.hashnode.dev/java-8s-consumer-predicate-and-supplier-functional-interfaces)
    - [快速理解 Consumer、Supplier、Predicate 与 Function](https://blog.csdn.net/qq_33591903/article/details/102948344)

## 1.2 方法引用（Method Reference）

!!! info  Docs
    [Method References](https://docs.oracle.com/javase/tutorial/java/javaOO/methodreferences.html)

方法引用进一步简化了函数式接口，可以直接使用现有的方法作为 Lambda 表达式，其基本语法如下。

```java
ClassName::MethodName
```

例如，在不使用方法引用时，我们必须将成员函数转换为 Lambda 表达式的写法。

```java
public class MethodReference {
    List<String> withoutMethodReference = cars.stream()
        .map(car -> car.toString())
        .collect(Collectors.toList());
}
```

而使用方法引用，则不用写成 Lambda 表达式的形式。

```java
public class MethodReference {
    List<String> methodReference = cars.stream()
        .map(Car::toString)
        .collect(Collectors.toList());
}
```

## 1.3 接口的默认方法和静态方法

!!! info  Docs
    [Default Methods & Static Methods](https://docs.oracle.com/javase/tutorial/java/IandI/defaultmethods.html)

Java 8 之前，接口中只能声明，而不能实现方法，这样就导致接口的变更会导致旧代码无法通过编译。Java 8 允许在接口中定义具有默认实现的方法，使得接口更新不破坏现有的类实现。

比如，这里 `Logging` 接口提供了一个默认方法，因此实现它的类可以选择不进行实现，而使用默认方法。为接口添加新方法时也可以添加默认方法，避免破坏现有类的实现。

```java
public class DefaultMethods {
    public interface Logging {
        void log(String message);
        default void log(String message, Date date) {
            System.out.println(date.toString() + ": " + message);
        }
    }

    public class LoggingImplementation implements Logging {
        @Override
        public void log(String message) {
            System.out.println(message);
        }
    }
}
```

对于静态方法，与静态成员变量类似，只能使用接口名调用。与默认方法类似，必须在接口中提供定义，但静态方法不能被重写。

```java
public class StaticMethods {
    public interface Logging {
        static void log(String message) {
            System.out.println(message);
        }
    }

    public static void main(String[] args) {
        Logging.log("Hello there");
    }
}
```

## 1.4 新的日期 API

!!! info  Docs
    [Package `java.time`](https://docs.oracle.com/javase/8/docs/api/java/time/package-summary.html)

### 1.4.1 时间类型

Java 8 引入了一个新的日期和时间 API，位于包 `java.time` 中，提供了更加灵活和易于使用的日期和时间处理功能。该API 在设计上遵循了不可变性和线程安全性的原则，并且提供了许多方便的方法来处理日期、时间、时间间隔和时区等。解决了原本 `java.util.Date` 中的很多问题。

`java.time` 中的主要类包括：

|                             类名                             |    内容     |     格式（一种可能）      |
| :----------------------------------------------------------: | :---------: | :-----------------------: |
| [`LocalDateTime`](https://docs.oracle.com/javase/8/docs/api/java/time/LocalDateTime.html) | 日期 + 时间 | `yyyy-MM-dd HH:mm:ss.SSS` |
| [`LocalDate`](https://docs.oracle.com/javase/8/docs/api/java/time/LocalDate.html) |    日期     |       `yyyy-MM-dd`        |
| [`LocalTime`](https://docs.oracle.com/javase/8/docs/api/java/time/LocalTime.html) |    时间     |      `HH:mm:ss.SSS`       |

### 1.4.2 基本使用

**日期格式化**

{% collapsecard %}

```java
public void newFormat() {
    //format yyyy-MM-dd
    LocalDate date = LocalDate.now();
    System.out.println(String.format("date format : %s", date));

    //format HH:mm:ss
    LocalTime time = LocalTime.now().withNano(0);
    System.out.println(String.format("time format : %s", time));

    //format yyyy-MM-dd HH:mm:ss
    LocalDateTime dateTime = LocalDateTime.now();
    DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
    String dateTimeStr = dateTime.format(dateTimeFormatter);
    System.out.println(String.format("dateTime format : %s", dateTimeStr));
}
```

{% endcollapsecard %}

**字符串转日期**

{% collapsecard %}

```java
LocalDate date = LocalDate.of(2021, 1, 26);
LocalDate.parse("2021-01-26");

LocalDateTime dateTime = LocalDateTime.of(2021, 1, 26, 12, 12, 22);
LocalDateTime.parse("2021-01-26 12:12:22");

LocalTime time = LocalTime.of(12, 12, 22);
LocalTime.parse("12:12:22");
```

{% endcollapsecard %}

**日期计算**

{% collapsecard %}

```java
////////// 计算一周后的日期 //////////
LocalDate localDate = LocalDate.now();
// 方法 1
LocalDate after = localDate.plus(1, ChronoUnit.WEEKS);
// 方法 2
LocalDate after2 = localDate.plusWeeks(1);
System.out.println("一周后日期：" + after);

////////// 计算算日期间隔 ///////////
LocalDate date1 = LocalDate.parse("2021-02-26");
LocalDate date2 = LocalDate.parse("2021-12-23");
Period period = Period.between(date1, date2);
System.out.println("date1 到 date2 相隔："
                   + period.getYears()  + " 年 "
                   + period.getMonths() + " 月 "
                   + period.getDays()   + " 天");
// 打印结果是 "date1 到 date2 相隔：0 年 9 月 27 天"
// 这里period.getDays()得到的天是抛去年月以外的天数，并不是总天数
// 如果要获取纯粹的总天数应该用下面的方法
long day = date2.toEpochDay() - date1.toEpochDay();
System.out.println(date2 + " 和 " + date2 + " 相差 " + day + " 天");
// Output：2021-12-23 和 2021-12-23 相差 300 天
```

**获取指定日期**

```java
LocalDate today = LocalDate.now();
// 本月第一天
LocalDate firstDayOfThisMonth = today.with(TemporalAdjusters.firstDayOfMonth());
// 本月最后一天
LocalDate lastDayOfThisMonth = today.with(TemporalAdjusters.lastDayOfMonth());
// 下一天
LocalDate nextDay = lastDayOfThisMonth.plusDays(1);
// 当年最后一天
LocalDate lastday = today.with(TemporalAdjusters.lastDayOfYear());
// 2021 年最后一个周日
LocalDate lastMondayOf2021 = LocalDate.parse("2021-12-31")
    .with(TemporalAdjusters.lastInMonth(DayOfWeek.SUNDAY));
```

{% endcollapsecard %}

**时区**

{% collapsecard %}

```java
// 当前时区时间
ZonedDateTime zonedDateTime = ZonedDateTime.now();
System.out.println("当前时区时间: " + zonedDateTime);
// 东京时间
ZoneId zoneId = ZoneId.of(ZoneId.SHORT_IDS.get("JST"));
ZonedDateTime tokyoTime = zonedDateTime.withZoneSameInstant(zoneId);
System.out.println("东京时间: " + tokyoTime);
// ZonedDateTime 转 LocalDateTime
LocalDateTime localDateTime = tokyoTime.toLocalDateTime();
System.out.println("东京时间转当地时间: " + localDateTime);
// LocalDateTime 转 ZonedDateTime
ZonedDateTime localZoned = localDateTime.atZone(ZoneId.systemDefault());
System.out.println("本地时区时间: " + localZoned);

// Output
// 当前时区时间: 2021-01-27T14:43:58.735+08:00[Asia/Shanghai]
// 东京时间: 2021-01-27T15:43:58.735+09:00[Asia/Tokyo]
// 东京时间转当地时间: 2021-01-27T15:43:58.735
// 当地时区时间: 2021-01-27T15:53:35.618+08:00[Asia/Shanghai]
```

{% endcollapsecard %}

## 1.5 Optional

!!! info  Docs
    [Class `Optional<T>`](https://docs.oracle.com/javase/8/docs/api/java/util/Optional.html)

Java 8 中通过引入 `Optional`，用于解决在处理可能为 `null` 的值时出现的 `NullPointerException`。`Optional` 类的设计目标是鼓励更好的编程实践，明确表示一个值可能为空，并鼓励开发人员在使用这些可能为空的值时进行显式的处理。`Optional` 类是一个容器对象，可以包含一个非空的值或者没有值（`null`）。

`Optional` 的简单使用示例如下，更多方法可参考官方文档或源码。

{% collapsecard %}

```java
import java.util.Optional;

public class OptionalDemo {
    public static void main(String[] args) {
        String value = "Hello";

        // 创建一个包含非空值的 Optional 对象
        Optional<String> optional = Optional.of(value);
        // 创建可能包含空值的 Optional 需要使用 ofNullable

        // 判断 Optional 对象是否包含值
        if (optional.isPresent()) {
            // 获取 Optional 对象中的值
            String result = optional.get();
            System.out.println("Value: " + result);
        }

        // 获取 Optional 对象中的值，如果没有值，则返回默认值
        String defaultValue = optional.orElse("Default Value");
        System.out.println("Default Value: " + defaultValue);

        // 对 Optional 对象中的值进行转换
        Optional<String> transformed = optional.map(String::toUpperCase);
        if (transformed.isPresent()) {
            System.out.println("Transformed Value: " + transformed.get());
        }
    }
}

// Output
// Value: Hello
// Default Value: Hello
// Transformed Value: HELLO
```

{% endcollapsecard %}

---

# 2. Java 9

## 2.1 Try-with-resources*

`try-with-resources` 用于在代码块结束时自动关闭实现 `AutoCloseable` 接口的资源。这一概念在 Java 7 中被提出。Java 9 对 `try-with-resources` 进行了改进，使其更加便利和灵活。

在 Java 9 之前，我们只能在 `try-with-resources` 块中声明变量，如下。

```java
try (Scanner scanner = new Scanner(new File("testRead.txt"));
    PrintWriter writer = new PrintWriter(new File("testWrite.txt"))) {
        // ...
    }
}
```

!!! Note
    可以在 `try-with-resource` 中 `try` 后的括号里用 `;` 分隔多条声明语句。🤔

在 Java 9 之后，在 `try-with-resources` 语句中可以使用 final 或 effectively-final 变量。

```java
final Scanner scanner = new Scanner(new File("testRead.txt"));
PrintWriter writer = new PrintWriter(new File("testWrite.txt"));
try (scanner; writer) {
    // ...
}
```

!!! Note
    effectively-final 简单来说就是没有被 `final` 修饰，但是值在初始化后从未更改的变量。

## 2.2 钻石操作符（Diamond Operator）*

钻石操作符是 Java 7 中引入的语法糖，用于在实例化泛型类时省略类型参数的重复声明。但是，在 Java 9 之前，我们不能在实例化内部匿名类时使用钻石操作符。因此，如下代码只能在 Java 9 之后的版本中通过编译。

```java
public class DiamondOperator {
    // 实例化内部匿名类时使用 <>
    StringAppender<String> appending = new StringAppender<>() {
        @Override
        public String append(String a, String b) {
            return new StringBuilder(a).append("-").append(b).toString();
        }
    };
    
    public abstract static class StringAppender<T> {
        public abstract T append(String a, String b);
    }
}
```

## 2.3 私有接口方法

Java 8 中允许接口实现默认方法，在 Java 9 中进一步允许接口实现私有方法。接口的私有的方法必须在接口声明中实现，并且只能在接口内部被调用，对于接口的实现类和其他类是不可见的。这就意味着，只有接口的默认方法可以调用接口的私有方法。接口的私有方法可以作为默认方法的辅助，简化代码，提高可读性。

接口私有方法的使用方法如下。

{% collapsecard %}

```java
public class PrivateInterfaceMethods {
    public static void main(String[] args) {
        TestingNames names = new TestingNames();
        System.out.println(names.fetchInitialData());
    }

    public static class TestingNames implements NamesInterface {
        public TestingNames() {
        }
    }

    public interface NamesInterface {
        default List<String> fetchInitialData() {
            try (BufferedReader br = new BufferedReader(
                new InputStreamReader(this.getClass().getResourceAsStream("/names.txt")))) {
                // 调用接口的私有方法
                return readNames(br);
            } catch (IOException e) {
                e.printStackTrace();
                return null;
            }
        }

        // 声明并实现私有方法
        private List<String> readNames(BufferedReader br)
            throws IOException {
            ArrayList<String> names = new ArrayList<>();
            String name;
            while ((name = br.readLine()) != null) {
                names.add(name);
            }
            return names;
        }
    }
}
```

{% endcollapsecard %}

## 2.4 模块化系统（Module System）

!!! info  Docs
    - [JEP 261: Module System](https://openjdk.org/jeps/261)
    
    - [Understanding Java 9 Modules](https://www.oracle.com/corporate/features/understanding-java-9-modules.html)

模块化系统也称为 Java 平台模块系统（Java Platform Module System，JPMS）。该特性的目标是改善 Java 平台的可伸缩性、安全性和性能。 模块化系统的主要思想是将 Java 平台分解为一系列模块，每个模块都有自己的封装和依赖关系，也可以被组合在一起，以构建更大的应用程序或库。

对于模块的声明，其基本语法如下，通过 `exports` 关键词还可以精准控制哪些类可以对外开放使用，哪些类只能内部使用。

```java
module demo.core {
    // 需要的模块
    requires demo.data;
    // 暴露的模块
    exports com.demo.core;
}

module demo.data {
    // 公开包内的所有公共成员
    export com.demo.data.table;
    // 限制访问成员范文，仅对某些包公开
    export com.demo.data.secret to com.demo.core;
}
```

更详细的解释可参考：[Java 9 揭秘（2. 模块化系统）](https://www.cnblogs.com/IcanFixIt/p/6947763.html)

## 2.5 集合工厂方法

Java 9 为集合框架引入了一组新的工厂方法，使创建和初始化**不可变集合**对象更加简洁和方便。这些工厂方法属于 `java.util` 包中的 `List`、`Set` 和 `Map` 接口，用于创建不可变的集合对象。集合工厂方法名均为 `of`，以下是其在不同集合中的使用方式。

```java
List<String> fruits = List.of("Apple", "Banana", "Orange");
Set<Integer> numbers = Set.of(1, 2, 3, 4, 5);
Map<String, Integer> studentScores = Map.of("Alice", 95, "Bob", 80, "Charlie", 90);
```

!!! error Danger
    集合工厂方法返回的是 `ImmutableCollections`，即不可变集合。因此如果你尝试修改其返回值，那么恭喜你将获得其抛出的 `UnsupportedOperationException`。🥳

## 2.6 Stream API*

Java 9 中为 `Stream` 类添加了一些更方便的方法。

- `default Stream<T> takeWhile(Predicate<T> predicate)`：返回从流开头开始的连续元素，直到遇到第一个不满足给定条件的元素。
  `default Stream<T> takeWhile(Predicate<T> predicate)`：返回从流的开头开始跳过满足给定条件的连续元素，直到遇到第一个不满足条件的元素。
- `static <T> Stream<T> ofNullable(T t)`：如果提供的元素为空（`null`），则创建一个空的 `Steam`；否则，将创建一个包含该元素的 `Stream`。
- `static <T> Stream<T> iterate(T seed, Predicate<T> hasNext, UnaryOperator<T> next)`：重载的 `iterate` 方法现在支持将 `Predicate` 作为终止迭代的条件。

Stream API 中新增方法的示例如下。

{% collapsecard %}

```java
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class StreamApiDemo {
    public static void main(String[] args) {
        // takeWhile() 方法示例
        List<Integer> smallNumbers = Stream.of(1, 2, 3, 4, 5, 6)
            .takeWhile(n -> n < 4)
            .collect(Collectors.toList());
        System.out.println(smallNumbers);
        // Output: [1, 2, 3]

        // dropWhile() 方法示例
        List<Integer> largeNumbers = Stream.of(1, 2, 3, 4, 5, 6)
            .dropWhile(n -> n < 4)
            .collect(Collectors.toList());
        System.out.println(largeNumbers);
        // Output: [4, 5, 6]

        // ofNullable() 方法示例
        String name = null;
        List<String> names = Stream.ofNullable(name)
            .collect(Collectors.toList());
        System.out.println(names);
        // Output: []

        // iterate() 方法的重载示例
        List<Integer> evenNumbers = Stream.iterate(0, n -> n < 10, n -> n + 2)
            .collect(Collectors.toList());
        System.out.println(evenNumbers);
        // Output: [0, 2, 4, 6, 8]
    }
}
```

{% endcollapsecard %}

!!! Info
    关于迭代器的更多内容可以参考：[Java 9 Steam iterate](https://javadeveloperzone.com/java-9/java-9-stream-iterate/)

## 2.7 进程 API*

Java 9 对进程 API 进行了一些改进，以提供更好的控制和管理应用程序的进程。这些改进主要集中在 `java.lang.Process` 类和相关类的增强，其主要改动如下。

- 引入了 `ProcessHandle` 类，代表一个本地操作系统进程的句柄。通过 `ProcessHandle` 类可以获取进程的 PID（进程标识符）、父进程的句柄、子进程的句柄以及其他进程相关的信息。其 `info()` 方法可以返回一个 `ProcessHandle.Info` 对象，以提供有关进程的详细信息，如进程的命令行参数、启动时间、累计 CPU 时间等。
- 改进了 `ProcessBuilder` 类，添加了一些新的方法，例如 `inheritIO()` 方法，它允许子进程继承父进程的标准输入、输出和错误流。还添加了 `redirectInput()、redirectOutput() 和 redirectError()` 方法，用于重定向子进程的标准输入、输出和错误流。
- 为 `Process` 类添加了 `destroyForcibly()` 方法，用于强制终止进程，无论进程是否响应。这与 `destroy()` 方法的区别在于，`destroy()` 方法会尝试优雅地终止进程，而 `destroyForcibly()` 方法会强制终止进程。

`ProcessHandle` 的基本用法如下。

```java
public class ProcessInfoDemo {
    public static void main(String[] args) {
        // 获取当前进程的 ProcessHandle
        ProcessHandle currentProcess = ProcessHandle.current();

        // 获取当前进程的 PID
        long pid = currentProcess.pid();
        System.out.println("当前进程的 PID：" + pid);

        // 获取当前进程的信息
        ProcessHandle.Info processInfo = currentProcess.info();
        System.out.println("命令行：" + processInfo.command().orElse(""));
        System.out.println("启动时间：" + processInfo.startInstant().orElse(null));
        System.out.println("累计 CPU 时间：" + processInfo.totalCpuDuration().orElse(null));
    }
}
```

## 2.8 JShell

Java 9 引入了一个名为 JShell 的命令行交互工具，其类似于 Python 的命令行模式，提供了一个方便的方式来进行 Java 代码的实时交互式探索和实验，简单的使用方法如下。JShell 支持 Tab 键显示补全提示，示例中的 "[Tab]" 指按 Tab 键。

```bash
$ jshell
|  Welcome to JShell -- Version 17.0.5
|  For an introduction type: /help intro

jshell> String greeting = "Hello there!";
greeting ==> "Hello there!"

jshell> System.out.pr[Tab]
print(     printf(    println(
jshell> System.out.println(greeting);
Hello there!

jshell> /exit
|  Goodbye

$ 
```

---

# 3. Java 10

!!! Info More
    [Java 10 Features](https://www.happycoders.eu/java/java-10-features/)

## 3.1 局部变量类型推断

Java 作为强类型语言，声明变量时必须明确指出类型。Java 10 引入了 `var` 关键字实现局部变量类型推断，可以让编译器根据上下文自动推断变量的类型，使代码更加简洁。

```java
// 声明局部变量的两种等价写法
List<Integer> explicitList = List.of(1, 2, 3);
var implicitList = List.of(1, 2, 3);
```

!!! Warning
    尽管 `var` 使代码更加简洁，但也不应滥用，导致可读性下降。一般使用场景是基本类型（如 `int`、`String`）的声明，以及接收显而易见的返回类型（如 `List.of`）。

## 3.2 Collections 和 Stream API*

Java 10 中，为集合与流增加了创建**不可变对象**的支持。

集合接口（`List`，`Set`，`Map`）中提供了新的静态方法返回集合的**不可变拷贝**。例如，`List` 中该方法的定义如下。

```java
static <E> List<E> copyOf(Collection<? extends E> coll) {
    return ImmutableCollections.listCopy(coll);
}
```

`java.util.stream.Collectors` 中新增了静态方法，用于将流中的元素收集为**不可变集合**，基本使用方法如下。

```java
var list = new ArrayList<Integer>();
list.stream().collect(Collectors.toUnmodifiableList());
list.stream().collect(Collectors.toUnmodifiableSet());
```

## 3.3 Optional*

`Optional` 类新增了 `orElseThrow()` 方法在值为空时抛出指定异常，使用方法如下。

```java
var value = nullableObject.orElseThrow(NullPointerException::new);
// 等价于
var value = nullableObject.orElseThrow(() -> new NullPointerException());
```

!!! note
    这里使用了方法引用，忘记的话可以点这里：[方法引用](#1-2-方法引用（Method-Reference）)。🫡

## 3.4 并行 Full GC 算法

G1 是一种低延时的垃圾回收器，可以非常精确地对停顿进行控制。从 Java 7 开始启用 G1 垃圾回收器，在 Java 9 中 G1 成为默认垃圾回收策略。不过，截止到 Java 9，G1 的 Full GC 采用的是单线程算法，会在发生 Full GC 时会严重影响性能。

Java 10 对 G1 进行了改进，引入了并行的 Full GC 算法，使用多个线程进行并行回收，为用户提供更好的体验。

---

# 4. Java 11

!!! Info More
    [Java 11 Features](https://www.happycoders.eu/java/java-11-features/)

## 3.1 Lambda 表达式参数类型推断

作为[局部变量类型推断](#3-1-局部变量类型推断)的扩展，Java 11 允许在 Lambda 表达式的参数生命中使用 `var` 关键字进行类型推断，示例如下。

```java
var filtered = Stream.of("Alpha", "Beta", "Gamma", "Delta")
        .filter((var x) -> x.contains("t"))
        .collect(Collectors.toList());
System.out.println(filtered);
// Type of `filtered`: List<String>
// Type of `x`: String
// Output: [Beta, Delta]
```

## 3.2 String*

Java 11 为 `String` 添加了一些工具方法，如下。

```java
// 判断字符串是否为空
"    \n\r\t".isBlank();         // true
// 去除字符串首尾空格
"     Java  ".strip();          // "Java"
// 去除字符串首部空格
"     Java  ".stripLeading();   // "Java "
// 去除字符串尾部空格
"     Java  ".stripTrailing();  // "     Java"
// 重复字符串 n 次
"Java ".repeat(3);              // "Java Java Java "
// 返回由 EOL 分隔的字符串集合
"A\nB\nC".lines().count();      // 3
"A\nB\nC".lines().collect(Collectors.toList());  // [A, B, C]
```

## 3.3 Optional*

Java 11 中为 `Optional` 新增了 `isEmpty()` 方法来判断指定的 `Optional` 对象是否为空，使用方法如下。

```java
var op = Optional.empty();
System.out.println(op.isEmpty());
// Output: true
```

## 3.4 Files*

Java 11 引入了一些新的文件方法，以提供更便捷和强大的文件操作功能，主要是 `writeString` 和 `readString`，用于写入和读取文件，其基本用法如下。

```java
import java.nio.file.Files;
import java.nio.file.Paths;

public class FileDemo {
    public static void main(String[] args) throws Exception {
        String filePath = "example.txt";

        // 写入文件
        String content = "Hello, world!";
        Files.writeString(Paths.get(filePath), content);

        // 读取文件
        String fileContent = Files.readString(Paths.get(filePath));
        System.out.println("文件内容：\n" + fileContent);
    }
}
```

更多内容可参考：

- [Files Class writeString() Method in Java with Examples](https://www.geeksforgeeks.org/files-class-writestring-method-in-java-with-examples/)
- [Files Class readString() Method in Java with Examples](https://www.geeksforgeeks.org/files-class-readstring-method-in-java-with-examples/)

## 3.5 标准 HTTP Client

Java 11 引入了标准的 HTTP 客户端 API，用于发送 HTTP 请求和处理响应，API 提供了一种原生的方式来进行 HTTP 通信，不再需要使用第三方库，基本的使用方法如下。

{% collapsecard %}

```java
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.concurrent.CompletableFuture;

public class HttpDemo {
	public static void main(String[] args) throws Exception {
		// 创建HTTP客户端
		HttpClient httpClient = HttpClient.newHttpClient();

		// 创建HTTP请求
		HttpRequest httpRequest = HttpRequest.newBuilder()
				.uri(URI.create("https://api.example.com/data"))
				.build();

		// 发送HTTP请求并异步获取响应
		CompletableFuture<HttpResponse<String>> future = httpClient.sendAsync(httpRequest, HttpResponse.BodyHandlers.ofString());

		// 处理响应
		future.thenAccept(response -> {
			int statusCode = response.statusCode();
			String responseBody = response.body();
			System.out.println("Status code: " + statusCode);
			System.out.println("Response body: " + responseBody);
		});

		// 等待异步请求完成
		future.join();
	}
}
```

{% endcollapsecard %}

!!! Note
    尽管 Java 11 提供了标准化的 HTTP Client，还是推荐使用第三方库 [OkHttp](https://square.github.io/okhttp/)。

---

# 5. Java 12

!!! Info More
    [Java 12 Features](https://www.happycoders.eu/java/java-12-features/)

## 5.1 String*

Java 12 再次为 `String` 添加了一些工具方法。

```java
////////// 为字符串增加缩进 //////////
String text = "Java";
text = text.indent(4); // 增加 4 个空格缩进
System.out.println(text);
text = text.indent(2); // 增加 2 个空格缩进
System.out.println(text);
text = text.indent(-4); // 减少 4 个空格缩进
System.out.println(text);
// Output: · 代表空格（这里是有 \n 的）
// ····Java
//
// ······Java
//
// ··Java

////////// 变换指定字符串 //////////
String result = "foo".transform(input -> input + " bar");
System.out.println(result);
```

!!! Note
    `indent` 方法会首先将字符串按 EOL 分隔为若干行，然后为每一行增加或减少缩进，并且会在不以 `\n` 结尾的行末添加 `\n`，最后再将这些行拼接为一个字符串。

## 5.2 Files*

Java 12 为 `Files` 引入了用于比较两个文件内容的 `mismatch()` 方法，返回第一个不匹配字符的位置，相同则返回 -1。使用方法如下。

{% collapsecard %}

```java
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;

public class FilesMismatchDemo {
    static Path createTempPath(String fileName) throws IOException {
        Path tempPath = Files.createTempFile(fileName, ".txt");
        tempPath.toFile().deleteOnExit();
        return tempPath;
    }

    public static void main(String[] args) throws IOException {
        Path filePath1 = createTempPath("test1");
        Path filePath2 = createTempPath("test2");
        Path filePath3 = createTempPath("test3");

        Files.writeString(filePath1, "Life is a progress, and not a station.");
        Files.writeString(filePath2, "Life is a progress, and not a station.");
        Files.writeString(filePath3, "Life is a progress, it's not a station.");

        long mismatch = Files.mismatch(filePath1, filePath2);
        System.out.println("File1 x File2 = " + mismatch); // match

        mismatch = Files.mismatch(filePath1, filePath3);
        System.out.println("File1 x File3 = " + mismatch); // mismatch
    }
}

// Output:
// File1 x File2 = -1
// File1 x File3 = 20
```

{% endcollapsecard %}

---

# 6. Java 13

!!! Info More
    [Java 13 Features](https://www.happycoders.eu/java/java-13-features/)

## 6.1 Socket API

Java 13 将 Socket API 的底层进行了重写，`NioSocketImpl` 是对原先 `PlainSocketImpl` 的直接替代，它使用 `java.util.concurrent` 包下的锁而不是同步方法。在 Java 13 中默认使用新的 Socket 实现。如果要使用旧实现，请使用 `-Djdk.net.usePlainSocketImpl=true`。

---

# 7. Java 14

!!! Info More
    [Java 14 Features](https://www.happycoders.eu/java/java-14-features/)

## 7.1 Switch 表达式

!!! info  Docs
    [Switch Expressions](https://docs.oracle.com/en/java/javase/14/language/switch-expressions.html)

不同于传统的 `switch` 语句，`switch` 表达式中不需要在每一个分支结尾使用 `break`，并且使程序可读性更高。

!!! Note
    传统的 `switch` 语句存在“直通式”（fallthrough）行为，即如果一个分支末尾没有 `break` 语句，就会接着执行下一个分支。

`switch` 表达式的每一个分支用于生成一个值，各个值跟在一个箭头 `->` 后面，如下。

```java
case "Summer", "Winter" -> 6;
```

在分支包含多条语句时，通过 `yield` 关键字返回该值，并结束该分支，如下。

```java
case "Spring" -> {
    System.out.println("It will be a silent Spring.");
    yield 6;
}
```

为了与旧的 `switch` 语句对称，Java 14 还引入了有“直通式”行为的 `switch` 表达式，所以总共有 4 中不同形式的 `switch`，如下。（以下 4 个例子的写法等价。）

**`switch` 表达式（无直通）**

```java
numLetters = switch (seasonName) {
    case "Spring" -> {
        System.out.println("It will be a silent Spring.");
        yield 6;
    }
    case "Summer", "Winter" -> 6;
    case "Fall" -> 4;
    default -> 1;
};
```

**`switch` 语句（无直通）**

```java
switch (seasonName) {
    case "Spring" -> {
        System.out.println("It will be a silent Spring.");
        numLetters = 6;
    }
    case "Summer", "Winter" -> numLetters = 6;
    case "Fall" -> numLetters = 4;
    default -> numLetters = 1;
}
```

**`switch` 表达式（有直通）**

```java
numLetters = switch (seasonName) {
    case "Spring":
        System.out.println("It will be a silent Spring.");
    case "Summer", "Winter":
        yield 6;
    case "Fall":
        yield 4;
    default:
        yield 1;
};
```

**`switch` 语句（有直通）**

这种形式即旧的 `switch` 语句。

```java
switch (seasonName) {
    case "Spring":
        System.out.println("It will be a silent Spring.");
    case "Summer", "Winter":
        numLetters = 6;
        break;
    case "Fall":
        numLetters = 4;
        break;
    default:
        numLetters = 1;
        break;
}
```

## 7.2 空指针提示

假如我们有这样一个链式调用，其中一个函数返回了 `null`，那么将会抛出 `NullPointerException`。

```java
long value = context.getService().getContainer().getMap().getValue();
```

在此之前，我们得到的信息非常有限，对定位异常位置帮助不大，如下。

```
Exception in thread "main" java.lang.NullPointerException
    at eu.happycoders.BusinessLogic.calculate(BusinessLogic.java:80)
```

但在 Java 14 中，我们可以得到更精确的提示，如下。

```
Exception in thread "main" java.lang.NullPointerException: 
Cannot invoke "Map.getValue()" because the return value of "Container.getMap()" is null
    at eu.happycoders.BusinessLogic.calculate(BusinessLogic.java:80)
```



---

# 8. Java 15

!!! Info
    [Java 15 Features](https://www.happycoders.eu/java/java-15-features/)

## 8.1 文本块（Text Blocks）

引入文本块之前，对于多行字符串，为了表达更清晰，我们只能通过拼接的方式获得。

```java
public class TextBlocks {
    public static void main(String[] args) {
        System.out.println(
            "<!DOCTYPE html>\n" +
            "<html>\n" +
            "     <head>\n" +
            "        <title>Example</title>\n" +
            "    </head>\n" +
            "    <body>\n" +
            "        <p>This is an example of a simple HTML " +
            "page with one paragraph.</p>\n" +
            "    </body>\n" +
            "</html>\n");
    }
}
```

在引入文本块后，我们可以使用如下的写法。

```java
public class TextBlocks {
    public static void main(String[] args) {
        System.out.println("""
                <!DOCTYPE html>
                <html>
                    <head>
                        <title>Example</title>
                    </head>
                    <body>
                        <p>This is an example of a simple HTML 
                        page with one paragraph.</p>
                    </body>
                </html>      
                """
        );
    }
}
```

!!! Note
    文本块会自动去除所有行的公共前导空格（也包括结尾 `"""` 的前导空格！），因此以上两个例子得到的字符串是相同的。

!!! error Danger
    必须在文本块开头的 `"""` 之后换行，否则无法通过编译，尽管该换行不会出现在最终的字符串中。😰

## 8.2 String 和 CharSequence*

Java 15 为 `String` 和 `CharSequence` 增加了一些方法。

- `String.formatted()`
- `String.stripIndent()`
- `String.translateEscapes()`
- `CharSequence.isEmpty()`

!!! Info
    这些函数的详细说明可参考：[New String and CharSequence Methods](https://www.happycoders.eu/java/java-15-features/#new-string-and-charsequence-methods)

## 8.3 新的 GC

为了解决原本 G1 垃圾回收器 Full GC 带来的性能影响，在 Java 10 中虽然引入了并行算法，但实际上仍会停止应用以进行垃圾回收。在 Java 15 中引入了两个新的低延迟 GC 以解决该问题：[ZGC](https://wiki.openjdk.org/display/zgc/Main) 和 [Shenandoah](https://wiki.openjdk.org/display/shenandoah/Main)。

两个新的垃圾回收器需要通过 JVM 参数启动，如下。

```bash
-XX:+UseZGC           # 使用 ZGC
-XX:+UseShenandoahGC  # 使用 Shenandoah
```

---

# 9. Java 16

!!! Info
    [Java 16 Features](https://www.happycoders.eu/java/java-16-features/)

## 9.1 instanceof 模式匹配

`instanceof` 模式匹配语法在 Java 16 中正式发布，可以简化我们对 `instanceof` 的使用。例如，在之前，我们必须在使用 `instanceof` 的分支语句中再次调用类型转换，并声明变量。

```java
Object obj = getObject();
if (obj instanceof String) {
    String s = (String) obj;
    if (s.length() > 5) {
        System.out.println(s.toUpperCase());
    }
} else if (obj instanceof Integer) {
    Integer i = (Integer) obj;
    System.out.println(i * i);
}
```

从 Java 16 开始，我们可以在使用 `instanceof` 的同时完成变量声明。

```java
if (obj instanceof String s) {          // 隐式转换为 String s
    if (s.length() > 5) {
        System.out.println(s.toUpperCase());
    }
} else if (obj instanceof Integer i) {  // 隐式转换为 Integer i
    System.out.println(i * i);
}
```

同时，在变量声明之后，还可以继续串联逻辑表达式。

```java
if (obj instanceof String s && s.length() > 5) {
    System.out.println(s.toUpperCase());
} else if (obj instanceof Integer i) {
    System.out.println(i * i);
}
```

此外，在以上的例子中，也可以看出，模式变量（即例子中的 `s` 和 `i`）不再是隐式 `final` 变量，而可以被改变。比如其中的 `String.toUpperCase()` 方法，在之前版本中无法通过编译。

!!! Note
    模式变量与局部变量类似，作用范围为所属的分支语句，并且会隐藏同名的成员变量，但是不能与已声明的局部变量同名。

## 9.2 Records

!!! info Docs
    [Record Classes](https://docs.oracle.com/en/java/javase/16/language/records.html)

`records` 在几轮的 Preview 后，在 Java 16 中正式发布。

`record` 类提供一种紧凑的语法来定义**不可变**数据类，其适用于只有构造方法与其基本语法如下。

```java
record Point(int x, int y) {}

// 使用
Point p = new Point(5, 10);
int x = p.x();
int y = p.y();
```

!!! Info
    更多关于 `record` 的内容，可参考：[Java Records](https://www.happycoders.eu/java/records/)。

## 9.3 Stream*

Java 16 再次为 `Stream` 引入了新的方法。

### 9.3.1 `Stream.toList()`

再此之前，要将 `Stream` 转换为列表，我们需要使用 `Collector.toList()` 方法，现在可以直接使用 `Stream.toList()` 方法进行转化。

```java
Stream.of("foo", "bar", "baz").collect(Collectors.toList());
Stream.of("foo", "bar", "baz").toList();
```

!!! Warning
    两种写法不完全等价！`Stream.toList()` 返回**不可变**列表，而 `Collector.toList` 对返回结果并没有过多的限制。

### 9.3.2 `Stream.mapMulti()`

我们可以使用该方法合并多个 `Stream`，使用方法如下。

```java
Stream<List<Integer>> stream = Stream.of(
    List.of(1, 2, 3),
    List.of(4, 5, 6),
    List.of(7, 8, 9));
List<Integer> list = stream.flatMap(List::stream).toList();
```

---

# 10. Java 17

!!! info Docs
    [Java 17 Features](https://www.happycoders.eu/java/java-17-features/)

## 10.1 密封类（Sealed Classes）

如果我们不希望一个类被继承，那么我们需要在声明该类时使用 `final` 关键字。但是如果我们希望这个类只能被某几个类继承，就需要用到新引入的密封类了。

密封类允许指定当前类可以被那些类继承，如下，`Vehicle` 可以，且只能被 `Bicycle` 和 `Car` **直接**继承。

```java
public sealed class Vehicle permits Bicycle, Car {...}
```

对于 `Bicycle` 和 `Car`，我们可以选择不继承。如果要继承，必须使用 `final`，`sealed`，或 `non-sealed` 关键字修饰。其中，`final` 和 `sealed` 含义不变，是对该类继承结构的限制。`non-sealed` 表示取消该类的继承限制，从而可以再次被任何类继承。

```java
public final class Bicycle extends Vehicle {...}   // 其他类无法继承 Bicycle
public non-sealed class Car extends Vehicle {...}  // 其他任何类都可以继承 Car
```

!!! Info
    关于密封类的更多内容，可参考：[Sealed Classes in Java](https://www.happycoders.eu/java/sealed-classes/)

## 10.2 十六进制格式化

!!! info Docs
    [Class `HexFormat`](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/util/HexFormat.html)

Java 17 提供了新的 `HexFormat` 类处理十六进制整数与字符传的转换，基本使用如下。

```java
HexFormat hexFormat = HexFormat.of();

System.out.println(hexFormat.toHexDigits('A'));
System.out.println(hexFormat.toHexDigits((byte) 10));
System.out.println(hexFormat.toHexDigits((short) 1_000));
System.out.println(hexFormat.toHexDigits(1_000_000));
System.out.println(hexFormat.toHexDigits(100_000_000_000L));
System.out.println(hexFormat.formatHex(new byte[] {1, 2, 3, 60, 126, -1}));

// Output:
// 0041
// 0a
// 03e8
// 000f4240
// 000000174876e800
// 0102033c7eff
```

---

# 11. Java 18+

更新的 Java 版本留给同学们自行查阅学习。🙂

- [Java 18 Features](https://www.happycoders.eu/java/java-18-features/)
- [Java 19 Features](https://www.happycoders.eu/java/java-19-features/)
- [Java 20 Features](https://www.happycoders.eu/java/java-20-features/)
- [Java 21 Features](https://www.happycoders.eu/java/java-21-features/)
