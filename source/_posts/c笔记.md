---
title: c笔记
updated: 1559136850
date: 2019-01-20 11:03:07
tags:
 - c
 - 正则表达式
---

## 随机数

```c
#include<cstdlib>
#include<ctime>
int main()
{
  srand((unsigned)time(NULL)); 
  rand()%x;                 //  取得(0,x)的随机整数：
  rand()%(b - a);             //  取得(a,b)的随机整数：
  rand()%(b - a) + a;           //  取得[a,b)的随机整数：
  rand()%(b - a + 1) + a;         //  取得[a,b]的随机整数：
  rand()%(b - a) + a + 1;         //  取得(a,b]的随机整数：
  rand()/double(RAND_MAX);  //  取得0-1之间的浮点数：
  return 0; 
}
```

## struct

### [strcut的声明](https://blog.csdn.net/dawn_after_dark/article/details/73555562)

```c
// 1
struct $struct_name
{
  ...;
};
struct $struct_name $variable_name;

// 2
typedef struct $struct_name
{
  ...;
}$struct_alias;
struct $struct_name $variable_name;
$struct_alias $variable_name;

// 3
struct $struct_name
{
  ...;
}$variable_name;
struct $struct_name $variable_name;

// 4
struct
{
  ...;
}$variable_name;
```

### [struct的创建和初始化](https://blog.csdn.net/fuyufjh/article/details/46040095)

```c
#define new(type, ...) ({\
       type* __t = (type*) malloc(sizeof(type));\
       *__t = (type){__VA_ARGS__};\
       __t; })
```

## 正则表达式

```c
#include <sys/types.h>
#include <stdio.h>
#include <regex.h>

int main()
{
  int status, i;
  int cflags = REG_EXTENDED;

  regmatch_t time_match[1];
  const size_t nmatch = 1;
  regex_t reg;
  const char *pattern = "s";
  char *buf = "sdsdfdfdffdfdfdf";

  regcomp(&reg, pattern, cflags);
  status = regexec(&reg, buf, nmatch, time_match, 0);
  if (status == REG_NOMATCH)
    Log("No match");
  else if (status == 0)
  {
    Log("Match:");
    for (i = time_match[0].rm_so; i < time_match[0].rm_eo; i ++)
    {
      putchar(buf[i]);
    }
    putchar('\n');
  }
  regfree(&reg);
  return 0;
}
```

## 画图

```c
#include <stdio.h>
#include <stdlib.h>
#include <termios.h>


void draw_rect(int color_num, int x, int y, int w, int h);
void init_screen();
void move_cursor(int direct_num, int dis);

enum colors{BLACK, RED, GREEN, YELLOW, BLUE, MAGENTA, CYAN, WHITE};
enum direct{UP, DOWN, RIGHT, LEFT};
const int height = 30;

  int
main()
{
  int i = 0, j = 0;
  char position[32];
  system("tput clear");
  init_screen();
  draw_rect(RED, 7, 0, 5, 5);
  draw_rect(GREEN, 17, 0, 5, 10);
  draw_rect(CYAN, 0, 11, 20, 6);
  while (1);
  return 0;
}

void draw_rect(int color_num, int x, int y, int w, int h)
{
  char offset[16];
  move_cursor(RIGHT, x);
  move_cursor(DOWN, y);
  for (int i = 0; i < h; i ++)
  {
    for (int j = 0; j < w; j ++)
      switch (color_num)
      {
        case BLACK:
          printf("\033[40m \33[0m");
          break;
        case RED:
          printf("\033[41m \33[0m");
          break;
        case GREEN:
          printf("\033[42m \33[0m");
          break;
        case YELLOW:
          printf("\033[43m \33[0m");
          break;
        case BLUE:
          printf("\033[44m \33[0m");
          break;
        case MAGENTA:
          printf("\033[45m \33[0m");
          break;
        case CYAN:
          printf("\033[46m \33[0m");
          break;
        case WHITE:
          printf("\033[47m \33[0m");
          break;
      }
    printf("\n");
    move_cursor(RIGHT, x);
  }
  move_cursor(LEFT, x + w);
  move_cursor(UP, y + h);
}

void move_cursor(int direct_num, int dis)
{
  for (int i = 0; i < dis; i ++)
    switch (direct_num)
    {
      case UP:
        printf("\033[A");
        break;
      case DOWN:
        printf("\033[B");
        break;
      case RIGHT:
        printf("\033[C");
        break;
      case LEFT:
        printf("\033[D");
        break;
    }
}

void init_screen()
{
  for (int i = 0; i < height; i ++)
    printf("\n");
  move_cursor(UP, height);
}
```

## 信号处理

- [菜鸟教程](http://www.runoob.com/cplusplus/cpp-signal-handling.html)

## mmap

```c
void my_mmap(const char *filename)
{
  struct stat sb;// statebuf
  int my_fd = 0;
  char *my_addr = NULL;// mmap地址

  my_fd = open(filename, O_RDONLY);// 只读
  if (my_fd == -1) {
    handle_error("open");
  }

  if (fstat(my_fd, &sb) == -1) {
    handle_error("fstat");
  }

  my_addr = mmap(
      NULL, sb.st_size,// size
      PROT_READ,
      MAP_PRIVATE,// MAP_SHARED
      my_fd,
      0// offset
  );
}
```

## pthread

```c
#include <assert.h>
#include <pthread.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <ctype.h>

#define GREEN(format, ...) \
  printf("\033[1;32m" format "\33[0m\n", ## __VA_ARGS__)
#define YELLOW(format, ...) \
  printf("\033[1;33m" format "\33[0m\n", ## __VA_ARGS__)
#define RED(format, ...) \
  printf("\033[1;31m[%s, %d]" format "\33[0m\n", __func__, __LINE__, ## __VA_ARGS__)
#define MAGENTA(format, ...) \
  printf("\033[1;35m[%s]" format "\33[0m\n", __func__, ## __VA_ARGS__)


struct thread_info {// thread_start的参数
  pthread_t thread_id;// 存放pthread_create的返回值(id)
  int       thread_num;// 自己定义的线程号
  char     *argv_string;// 命令行的字符串
};

void *thread_start(void *arg);
// display address near top of our stack, and return upper-cased copy of argv_string

int main(int argc, char *argv[])
{
  int num_threads;// 线程数
  struct thread_info *tinfo;
  pthread_attr_t attr;// 线程属性
  void *res;

  num_threads = argc - optind;// 线程数

  if (pthread_attr_init(&attr) != 0) {// 初始化线程属性
    RED("pthread_attr_init");
    assert(0);
  }

  tinfo = calloc(num_threads, sizeof(struct thread_info));// 申请线程空间
  if (tinfo == NULL) {
    RED("calloc");
    assert(0);
  }

  for (int i = 0; i < num_threads; i ++) {
    tinfo[i].thread_num = i;
    tinfo[i].argv_string = argv[optind + i];

    if (pthread_create(&tinfo[i].thread_id, &attr,
        &thread_start, &tinfo[i]) != 0) {// 创建线程
      RED("pthread_create");
      assert(0);
    }
  }

  if (pthread_attr_destroy(&attr) != 0) {// 删除线程属性
    RED("pthread_attr_destroy");
    assert(0);
  }

  for (int i = 0; i < num_threads; i++) {
    if (pthread_join(tinfo[i].thread_id, &res) != 0) {// 合并线程
      RED("pthread_join");
    assert(0);
    }

    GREEN("Joined with thread %d; returned value was %s",
        tinfo[i].thread_num, (char *) res);

    free(res);// 释放结构体中字符串的空间
  }

  free(tinfo);// 释放线程空间
  exit(EXIT_SUCCESS);
}

void *thread_start(void *arg)
{
  struct thread_info *tinfo = arg;// &tinfo[num]
  char *uargv, *p;

  YELLOW("Thread %d: top of stack near %p; argv_string=%s",
      tinfo->thread_num, &p, tinfo->argv_string);

  uargv = strdup(tinfo->argv_string);// 复制字符串(申请内存)
  if (uargv == NULL) {
    RED("strdup");
    assert(0);
  }

  for (p = uargv; *p != '\0'; p++) {// 修改uargv
    *p = toupper(*p);
  }

  return uargv;
}

```
