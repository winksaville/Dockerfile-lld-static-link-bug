# Repo
https://github.com/winksaville/Dockerfile-lld-static-link-bug.git

## Pull image
```bash
docker pull winksaville/lld-static-link-bug
```

## Build image

```bash
docker build -t winksaville/lld-static-link-bug:arch .
```

## Run image which runs `make run-gold` and then `make run-lld`

I created directory `xx` and run from in there because docker apps
are running as root and this just isolates the artifacts
a little:

```bash
wink@wink-desktop:~/
$ mkdir xx && cd xx
wink@wink-desktop:~/xx
$ docker run --name lld-bug -v `pwd`:`pwd` -w `pwd` --rm -it winksaville/lld-static-link-bug:arch
Cloning into 'lld-bug'...
remote: Counting objects: 7, done.
remote: Compressing objects: 100% (6/6), done.
remote: Total 7 (delta 0), reused 7 (delta 0), pack-reused 0
Unpacking objects: 100% (7/7), done.
clang++ -fuse-ld=gold -o main-gold -v -static -pthread main.cpp
clang version 6.0.0 (tags/RELEASE_600/final)
Target: x86_64-pc-linux-gnu
Thread model: posix
InstalledDir: /usr/sbin
Found candidate GCC installation: /usr/lib/gcc/x86_64-pc-linux-gnu/8.1.1
Found candidate GCC installation: /usr/lib64/gcc/x86_64-pc-linux-gnu/8.1.1
Found candidate GCC installation: /usr/sbin/../lib/gcc/x86_64-pc-linux-gnu/8.1.1
Found candidate GCC installation: /usr/sbin/../lib64/gcc/x86_64-pc-linux-gnu/8.1.1
Selected GCC installation: /usr/sbin/../lib64/gcc/x86_64-pc-linux-gnu/8.1.1
Candidate multilib: .;@m64
Candidate multilib: 32;@m32
Selected multilib: .;@m64
 "/usr/bin/clang-6.0" -cc1 -triple x86_64-pc-linux-gnu -emit-obj -mrelax-all -disable-free -disable-llvm-verifier -discard-value-names -main-file-name main.cpp -static-define -mrelocation-model pic -pic-level 2 -pic-is-pie -mthread-model posix -mdisable-fp-elim -fmath-errno -masm-verbose -mconstructor-aliases -munwind-tables -fuse-init-array -target-cpu x86-64 -dwarf-column-info -debugger-tuning=gdb -v -resource-dir /usr/lib/clang/6.0.0 -internal-isystem /usr/sbin/../lib64/gcc/x86_64-pc-linux-gnu/8.1.1/../../../../include/c++/8.1.1 -internal-isystem /usr/sbin/../lib64/gcc/x86_64-pc-linux-gnu/8.1.1/../../../../include/c++/8.1.1/x86_64-pc-linux-gnu -internal-isystem /usr/sbin/../lib64/gcc/x86_64-pc-linux-gnu/8.1.1/../../../../include/c++/8.1.1/backward -internal-isystem /usr/local/include -internal-isystem /usr/lib/clang/6.0.0/include -internal-externc-isystem /include -internal-externc-isystem /usr/include -fdeprecated-macro -fdebug-compilation-dir /home/wink/xx/lld-bug -ferror-limit 19 -fmessage-length 186 -pthread -stack-protector 2 -fobjc-runtime=gcc -fcxx-exceptions -fexceptions -fdiagnostics-show-option -fcolor-diagnostics -o /tmp/main-5c690b.o -x c++ main.cpp
clang -cc1 version 6.0.0 based upon LLVM 6.0.0 default target x86_64-pc-linux-gnu
ignoring nonexistent directory "/include"
#include "..." search starts here:
#include <...> search starts here:
 /usr/sbin/../lib64/gcc/x86_64-pc-linux-gnu/8.1.1/../../../../include/c++/8.1.1
 /usr/sbin/../lib64/gcc/x86_64-pc-linux-gnu/8.1.1/../../../../include/c++/8.1.1/x86_64-pc-linux-gnu
 /usr/sbin/../lib64/gcc/x86_64-pc-linux-gnu/8.1.1/../../../../include/c++/8.1.1/backward
 /usr/local/include
 /usr/lib/clang/6.0.0/include
 /usr/include
End of search list.
 "/usr/sbin/ld.gold" -m elf_x86_64 -static -o main-gold /usr/sbin/../lib64/gcc/x86_64-pc-linux-gnu/8.1.1/../../../../lib64/crt1.o /usr/sbin/../lib64/gcc/x86_64-pc-linux-gnu/8.1.1/../../../../lib64/crti.o /usr/sbin/../lib64/gcc/x86_64-pc-linux-gnu/8.1.1/crtbeginT.o -L/usr/sbin/../lib64/gcc/x86_64-pc-linux-gnu/8.1.1 -L/usr/sbin/../lib64/gcc/x86_64-pc-linux-gnu/8.1.1/../../../../lib64 -L/usr/bin/../lib64 -L/lib/../lib64 -L/usr/lib/../lib64 -L/usr/sbin/../lib64/gcc/x86_64-pc-linux-gnu/8.1.1/../../.. -L/usr/bin/../lib -L/lib -L/usr/lib /tmp/main-5c690b.o -lstdc++ -lm --start-group -lgcc -lgcc_eh -lpthread -lc --end-group /usr/sbin/../lib64/gcc/x86_64-pc-linux-gnu/8.1.1/crtend.o /usr/sbin/../lib64/gcc/x86_64-pc-linux-gnu/8.1.1/../../../../lib64/crtn.o
./main-gold 4 5 6
argv[0]: ./main-gold
argv[1]: 4
argv[2]: 5
argv[3]: 6
clang++ -fuse-ld=lld  -o main-lld  -v -static -pthread main.cpp -Wl,--reproduce=main-lld-repro.tar
clang version 6.0.0 (tags/RELEASE_600/final)
Target: x86_64-pc-linux-gnu
Thread model: posix
InstalledDir: /usr/sbin
Found candidate GCC installation: /usr/lib/gcc/x86_64-pc-linux-gnu/8.1.1
Found candidate GCC installation: /usr/lib64/gcc/x86_64-pc-linux-gnu/8.1.1
Found candidate GCC installation: /usr/sbin/../lib/gcc/x86_64-pc-linux-gnu/8.1.1
Found candidate GCC installation: /usr/sbin/../lib64/gcc/x86_64-pc-linux-gnu/8.1.1
Selected GCC installation: /usr/sbin/../lib64/gcc/x86_64-pc-linux-gnu/8.1.1
Candidate multilib: .;@m64
Candidate multilib: 32;@m32
Selected multilib: .;@m64
 "/usr/bin/clang-6.0" -cc1 -triple x86_64-pc-linux-gnu -emit-obj -mrelax-all -disable-free -disable-llvm-verifier -discard-value-names -main-file-name main.cpp -static-define -mrelocation-model pic -pic-level 2 -pic-is-pie -mthread-model posix -mdisable-fp-elim -fmath-errno -masm-verbose -mconstructor-aliases -munwind-tables -fuse-init-array -target-cpu x86-64 -dwarf-column-info -debugger-tuning=gdb -v -resource-dir /usr/lib/clang/6.0.0 -internal-isystem /usr/sbin/../lib64/gcc/x86_64-pc-linux-gnu/8.1.1/../../../../include/c++/8.1.1 -internal-isystem /usr/sbin/../lib64/gcc/x86_64-pc-linux-gnu/8.1.1/../../../../include/c++/8.1.1/x86_64-pc-linux-gnu -internal-isystem /usr/sbin/../lib64/gcc/x86_64-pc-linux-gnu/8.1.1/../../../../include/c++/8.1.1/backward -internal-isystem /usr/local/include -internal-isystem /usr/lib/clang/6.0.0/include -internal-externc-isystem /include -internal-externc-isystem /usr/include -fdeprecated-macro -fdebug-compilation-dir /home/wink/xx/lld-bug -ferror-limit 19 -fmessage-length 186 -pthread -stack-protector 2 -fobjc-runtime=gcc -fcxx-exceptions -fexceptions -fdiagnostics-show-option -fcolor-diagnostics -o /tmp/main-f7be50.o -x c++ main.cpp
clang -cc1 version 6.0.0 based upon LLVM 6.0.0 default target x86_64-pc-linux-gnu
ignoring nonexistent directory "/include"
#include "..." search starts here:
#include <...> search starts here:
 /usr/sbin/../lib64/gcc/x86_64-pc-linux-gnu/8.1.1/../../../../include/c++/8.1.1
 /usr/sbin/../lib64/gcc/x86_64-pc-linux-gnu/8.1.1/../../../../include/c++/8.1.1/x86_64-pc-linux-gnu
 /usr/sbin/../lib64/gcc/x86_64-pc-linux-gnu/8.1.1/../../../../include/c++/8.1.1/backward
 /usr/local/include
 /usr/lib/clang/6.0.0/include
 /usr/include
End of search list.
 "/usr/sbin/ld.lld" -m elf_x86_64 -static -o main-lld /usr/sbin/../lib64/gcc/x86_64-pc-linux-gnu/8.1.1/../../../../lib64/crt1.o /usr/sbin/../lib64/gcc/x86_64-pc-linux-gnu/8.1.1/../../../../lib64/crti.o /usr/sbin/../lib64/gcc/x86_64-pc-linux-gnu/8.1.1/crtbeginT.o -L/usr/sbin/../lib64/gcc/x86_64-pc-linux-gnu/8.1.1 -L/usr/sbin/../lib64/gcc/x86_64-pc-linux-gnu/8.1.1/../../../../lib64 -L/usr/bin/../lib64 -L/lib/../lib64 -L/usr/lib/../lib64 -L/usr/sbin/../lib64/gcc/x86_64-pc-linux-gnu/8.1.1/../../.. -L/usr/bin/../lib -L/lib -L/usr/lib /tmp/main-f7be50.o --reproduce=main-lld-repro.tar -lstdc++ -lm --start-group -lgcc -lgcc_eh -lpthread -lc --end-group /usr/sbin/../lib64/gcc/x86_64-pc-linux-gnu/8.1.1/crtend.o /usr/sbin/../lib64/gcc/x86_64-pc-linux-gnu/8.1.1/../../../../lib64/crtn.o
./main-lld 1 2 3
make: *** [Makefile:3: run-lld] Segmentation fault (core dumped)
```

## Run the image interactively to debug

To debug the resultingimage using `gdb` you can run the image
interactively by adding `--entrypoint=/usr/bin/bash`:
```bash
wink@wink-desktop:~/xx
$ docker run --privileged --name lld-bug -v `pwd`:`pwd` -w `pwd` --rm -it --entrypoint='/usr/bin/bash' winksaville/lld-static-link-bug:arch
[root@5ff28ea3fa1f xx]# cd lld-bug/
[root@5ff28ea3fa1f lld-bug]# gdb -q --args ./main-lld 1 2 3
Reading symbols from ./main-lld...done.
(gdb) r
Starting program: /home/wink/xx/lld-bug/main-lld 1 2 3

Program received signal SIGSEGV, Segmentation fault.
0x0000000000384256 in _dl_get_origin ()
(gdb) bt
#0  0x0000000000384256 in _dl_get_origin ()
#1  0x00000000003838bf in _dl_non_dynamic_init ()
#2  0x00000000002ef141 in __libc_init_first ()
#3  0x00000000002eee37 in __libc_start_main ()
#4  0x000000000025302a in _start ()
(gdb) display/i $pc
1: x/i $pc
=> 0x384256 <_dl_get_origin+342>:	movb   $0x0,(%rax)
(gdb) i r 
rax            0x364ca0	3558560
rbx            0x7fffffffdb70	140737488345968
rcx            0x3ae460	3859552
rdx            0x364c60	3558496
rsi            0x7fffffffdb70	140737488345968
rdi            0x3ae460	3859552
rbp            0x16	0x16
rsp            0x7fffffffdb70	0x7fffffffdb70
r8             0x3	3
r9             0x0	0
r10            0xfffffffffffff000	-4096
r11            0x0	0
r12            0x3ae460	3859552
r13            0x0	0
r14            0x3994f8	3773688
r15            0x0	0
rip            0x384256	0x384256 <_dl_get_origin+342>
eflags         0x10202	[ IF RF ]
cs             0x33	51
ss             0x2b	43
ds             0x0	0
es             0x0	0
fs             0x0	0
gs             0x0	0
(gdb) disassemble $rax
Dump of assembler code for function __mempcpy_avx_unaligned_erms:
   0x0000000000364ca0 <+0>:	mov    %rdi,%rax
   0x0000000000364ca3 <+3>:	add    %rdx,%rax
   0x0000000000364ca6 <+6>:	jmp    0x364cb3 <__memmove_avx_unaligned_erms+3>
End of assembler dump.
(gdb) 

```

## Push to docker

```bash
docker push winksaville/lld-static-link-bug:arch
```
