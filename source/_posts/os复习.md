---
title: os复习
updated: 1561259906
date: 2019-06-21 09:03:02
tags:
categories:
 - 操作系统
---

- 1题基本概念
- 2题进程和虚存
- 1题文件系统
- 1题并发编程

# 编译 链接

## `gcc -o`的系统调用

- 预处理->编译->链接

- `strace`:
 - `-f`:跟踪由fork调用所产生的子进程

## `elf`文件格式

- `readelf`命令

# 终端 shell

## 为什么按键能显示在屏幕上?按下回车命令就会执行?

### **I/O设备模型**

- I/O设备:可以与计算机(?)进行数据传输的硬件(?)
 1. 发送命令
 2. 读取状态
 3. 传输数据
- 设备驱动程序:进程(operating system?)与设备控制器(?)之间的通信程序

```bash
$ ps
  PID TTY          TIME CMD
 6577 pts/3    00:00:00 zsh
 9178 pts/3    00:00:00 ps

$ ps -l
F S   UID   PID  PPID  C PRI  NI ADDR SZ WCHAN  TTY          TIME CMD
0 S  1000  6577  1883  0  80   0 -  7676 sigsus pts/3    00:00:00 zsh
4 R  1000  9265  6577  0  80   0 -  7531 -      pts/3    00:00:00 ps
```

- polling
- interupt
- hybrid
- DMA(直接存储器访问):允许外设可以独立地直接读写系统的存储器(?),而不需要cpu介入处理

## `./hello`如何被执行

1. 先调用`fork`
2. 子进程调用`execve`->`hello`
3. 父进程`wait`

- `execve`不会改变进程文件的状态,只会把进程替换成另一个程序

```bash
$ sudo echo "a" > shit
zsh: 权限不够: shit # 重定向发生在`execve`之前,open失败

$ sudo bash -c 'echo "a" > shit'
```

# 加载器(文件如何变成进程?)

## **第一条指令在哪里?**

## `main`函数执行之前,系统发生了什么?

```bash
gdb shit

(gdb) starti
Program stopped.
0x00007ffff7fd4090 in _start () from /lib64/ld-linux-x86-64.so.2 
# 不是hello的_start,是加载器的_start(静态链接)(动态加载在操作系统的...)

(gdb) info inferior # 查看进程号
* 1    process 6569      /shit

$ pmap 6569
6569:   /shit
0000555555554000      4K r---- shit # 代码和数据
0000555555555000      4K r-x-- shit
0000555555556000      4K r---- shit
0000555555557000      8K rw--- shit
00007ffff7fce000     12K r----   [ anon ]
00007ffff7fd1000      8K r-x--   [ anon ]
00007ffff7fd3000      4K r---- ld-2.28.so
00007ffff7fd4000    128K r-x-- ld-2.28.so
00007ffff7ff4000     32K r---- ld-2.28.so
00007ffff7ffc000      8K rw--- ld-2.28.so
00007ffff7ffe000      4K rw---   [ anon ]
00007ffffffde000    132K rw---   [ stack ]
ffffffffff600000      4K r-x--   [ anon ]
 total              352K

(gdb) b _start
Breakpoint 1 at 0x555555555060

(gdb) c
Breakpoint 1, 0x0000555555555060 in _start ()

$ pmap 6569
6569:   /shit
0000555555554000      4K r---- shit
0000555555555000      4K r-x-- shit
0000555555556000      4K r---- shit
0000555555557000      4K r---- shit
0000555555558000      4K rw--- shit
00007ffff7dc3000    136K r---- libc-2.28.so # printf的代码
00007ffff7de5000   1476K r-x-- libc-2.28.so
00007ffff7f56000    304K r---- libc-2.28.so
00007ffff7fa2000      4K ----- libc-2.28.so
00007ffff7fa3000     16K r---- libc-2.28.so
00007ffff7fa7000      8K rw--- libc-2.28.so
00007ffff7fa9000     24K rw---   [ anon ]
00007ffff7fce000     12K r----   [ anon ]
00007ffff7fd1000      8K r-x--   [ anon ]
00007ffff7fd3000      4K r---- ld-2.28.so
00007ffff7fd4000    128K r-x-- ld-2.28.so
00007ffff7ff4000     32K r---- ld-2.28.so
00007ffff7ffc000      4K r---- ld-2.28.so
00007ffff7ffd000      4K rw--- ld-2.28.so
00007ffff7ffe000      4K rw---   [ anon ]
00007ffffffde000    132K rw---   [ stack ]
ffffffffff600000      4K r-x--   [ anon ]
 total             2320K

...
Breakpoint 1, 0x0000555555555149 in main ()

$ pmap 6569
# 输出同上
```

# printf

## `printf`代码位于何处?

- `objdump`

```c
static void __attribute__ ((constructor)) fuck()// 在main之前执行
{
  printf("hello\n");// 编译优化,puts
}
```

## **实现线程安全的`printf`**?(20分的并发编程题)

### [PV操作](https://blog.csdn.net/wzh402/article/details/44889671)

- P操作`P(S)`:将信号量S减去1,若结果小于0,则把调用`P(S)`的进程置成等待信号量S的状态,即为请求资源
- V操作`V(S)`:将信号量S加上1,若结果不大于0,则释放一个等待信号量S的进程,即为释放资源

### [生产者消费者问题](https://blog.csdn.net/liushall/article/details/81569609)

- 条件变量(先上锁?)

```c
void producer() 
{
  while (1) {
    mutex_lock(&mutex);

    if (count == n) wait(&notfull, &mutex);
    produce();
    count ++;
    signal(&notempty);

    mutex_unlock(&mutex);
  }
}

void consumer() 
{
  while (1) {
    mutex_lock(&mutex);

    if (count == 0) wait(&notempty, &mutex);
    consume();
    count --;
    signal(&notfull);
    
    mutex_unlock(&mutex);
  }
}
```

- 信号量(后上锁?)

```c
void producer()
{
  while (1) {
    P(&space);
    mutex_lock(&mutex);

    produce();

    mutex_unlock(&mutex);
    V(&items);
  }
}

void consumer()
{
  while (1) {
    P(&items);
    mutex_lock(&mutex);

    consume();

    mutex_unlock(&mutex);
    V(&space);
  }
}
```

## printf末尾换行

> 异常退出

```c
int main()
{
  FILE *fp = fopen("del", "w");
  setbuf(fp, NULL); // 自定义fp的缓冲区,NULL:不要缓冲区
  fputs("fuck", fp);
  assert(0);// 程序异常退出
  return 0;
}
```

```bash
# cont'd
$ gcc hello.c -o shit
$ ./shit
shit: hello.c:11: main: Assertion `0' failed.

$ cat del
fuck%
```

> fork

```c
int main()
{
  for (int i = 0; i < n; i ++) {
    fork();
    printf("hello\n");
  }
  return 0;
}
```

| n | `./hello │ wc -l` | `./hello` |
| :-: | :--: | :--: |
| 1 | 2 | 2 |
| 2 | 8 | 6 |

```c
int main()
{
  setbuf(stdout, NULL);
  for (int i = 0; i < n; i ++) {
    fork();
    printf("hello\n");
  }
  return 0;
}
```

| n | `./hello │ wc -l` | `./hello` |
| :-: | :--: | :--: |
| 1 | 2 | 2 |
| 2 | 6 | 6 |

## printf的系统调用

- `ltrace`命令
- libc缓冲区
- write系统调用

# write

## write写到哪里?

- 文件描述符对应的文件,例如一个设备(`/dev/ttyx`),或是文件系统中的一个文件

## **文件系统如何实现**?

- 文件系统:存储和组织计算机数据的方法(?)

### **FAT**(文件分配表)

[FAT32文件系统快速入门,CSDN](https://blog.csdn.net/u010650845/article/details/60881687)
[长文件名](https://blog.csdn.net/u010650845/article/details/60780979)

### **ext2**(inode)

[鸟哥的Linux私房菜:Linux的ext2档案系统](http://linux.vbird.org/linux_basic/0230filesystem.php#top)

- 最大单一文件大小
 1. 12直接,1间接,1双间接,1三间接,设块大小为x(kb),1个block号4byte
 2. `x*12 + x*(x*1024/4) + x*(x*1024/4)^2 + x*(x*1024/4)^3`(byte)
- 资料存放区:`inode table`,`data block`
- `metadata`:`superblock`,`block bitmap`,`inode bitmap`

## **如何保护我们的数据不受损害**?

### RAID

[鸟哥的Linux私房菜:Software RAID](http://linux.vbird.org/linux_basic/0420quota.php#raid)

| RAID | 容量 | 容错 | 顺序度 | 随机读 | 顺序写 | 随机写 |
| :--: | :--: | :--: | :----: | :----: | :----: | :----: |
| 0 | $n$ | 0 | $n$ | $n$ | $n$ | $n$ |
| 1 | $n/2$ | | $> n/2$ | $n$ | $n/2$ | $n/2$ |
| 4 | $n-1$ | 1 | $n-1$ | $n-1$ | $n-1$ | $1/2$ |
| 5 | $n-1$ | 1 | $n-1$ | $n$ | $n-1$ | **$n/4$** |

### fsck

扫描inodes里的所有数据块,检查bitmap的一致性

### 日志

[鸟哥的Linux私房菜:Linux的ext2档案系统](http://linux.vbird.org/linux_basic/0230filesystem.php#top)

在磁盘上保存所有对数据结构的操作,每次启动时重做这些操作,在内存里重新建立文件系统

优化
- 批处理
- Metadata journaling
 - 只对inode和bitmap做journaling,数据可以随意写入
