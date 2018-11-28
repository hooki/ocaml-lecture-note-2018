# Ocaml Calculator
Ocaml로 작성된 계산기입니다. 아래와 같이 실행할 수 있습니다.
```
$ ./run testcase/test01.in
==== expression ====
1 + 3

====== result ======
4.
```

## Ocaml 설치
### Windows10
Windows PowerShell을 관리자 권한으로 실행(Window+X -> A)해서 아래의 커맨드를 입력한 후 다시 시작합니다.
```
$ Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
```
Microsoft Store에서 Ubuntu를 검색해서 다운 받습니다.  
다운 받은 Ubuntu를 실행한 후 username과 password를 입력합니다.  
https://aka.ms/wslinstall 에서 더 자세한 정보를 찾을 수 있습니다.

우분투의 모든 package를 최신 상태로 업데이트합니다.
```
$ sudo apt-get update
$ sudo apt-get upgrade
```
Ocaml을 설치합니다.
```
$ sudo apt-get install ocaml
```
### ubuntu
터미널을 실행한 후 Ocaml을 설치합니다.
```
$ sudo apt-get install ocaml
```
### macOS
Bash를 열고 Ocaml을 설치합니다.
```
$ sudo brew install ocaml
```
https://ocaml.org/docs/install.html/#macOS 에서 더 자세한 정보를 찾을 수 있습니다.

## 빌드
터미널을 실행하고 깃을 이용해서 프로젝트를 다운 받습니다.
```
$ cd (Your Project Directory)
$ git clone https://github.com/kukosmos/ocaml-lecture-note-2018.git
```
소스코드의 위치로 이동해서 빌드합니다.
```
$ cd ocaml-lecture-note-2018/W3/src
$ make
```
### with WSL
Windows의 폴더는 /mnt/(Windows directory)로 접근할 수 있습니다.  
예를 들어, D:\\kosmos 폴더의 경우는 아래와 같이 접근 할 수 있습니다.
```
$ cd /mnt/d/kosmos
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
