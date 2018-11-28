# Ocaml Calculator
Ocaml로 작성된 계산기입니다. 아래와 같이 실행할 수 있습니다.
```
$ ./run testcase/test01.in
==== expression ====
let a = 4;
def f(x) = a + x;
f(6)

====== result ======
10.
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
$ cd W4/src
$ make
```

## 실행
```
<Usage>
$ ./run (input file)            calculate expression in input file
```
예를 들어, 아래와 같이 실행하면 됩니다.
```
$ ./run testcase/test01.in
```

## Remove
```
$ make clean
```
