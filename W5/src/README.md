# Ocaml Calculator
Ocaml로 작성된 간단한 언어입니다. 아래와 같이 실행할 수 있습니다.
```
$ ./run testcase/test01.in
==== expression ====
let x = ref 0;
x := !x + 3;
!x

====== result ======
3
```

## git fetch & pull
git을 이용해서 자료와 코드를 최신버전으로 업데이트 합니다.
```
$ cd (Your Project Directory)/ocaml-lecture-note-2018
$ git fetch
$ git pull
```

## 빌드
```
$ cd W5/src
$ make
```

## 실행
```
<Usage>
$ ./run (input file)            run input file
```
예를 들어, 아래와 같이 실행하면 됩니다.
```
$ ./run testcase/test01.in
```

## Remove
```
$ make clean
```
