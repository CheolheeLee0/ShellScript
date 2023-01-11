#!/usr/bin/bash

# 1. 디렉토리 위치 출력
echo $(which bash) 


# 2. 스크립트 실행
./script.sh


# 3. 문자열 안에 변수 넣기
name="inpa" # 변수 선언 및 대입
pass=123123 # 따옴표로 감싸든 말든 문자열로 저장됨
echo $name # {}가 있으나 없으나 $만으로 변수의 값을 넣어줄 수 있으나, 문자열을 붙여서 쓸려면 ${} 를 사용해야 한다.
echo "my name is mr.${name}"
printf "%s" $pass


# 4. 전역변수, 지역변수
# 기본적으로 전역 변수로 지정
string="hello world"
 
function string_test() {
    # local을 붙여야 지역변수로 인식. 만일 local을 빼면 전역변수 덮어쓰기가 되버림
    local string="hello local @@"
    echo ${string}
}
 
# 함수 호출
string_test # > hello local @@
echo ${string} # > hello world
 
# 변수 초기화
unset string


# 5. 변수 타입 지정
# -r 읽기 전용 타입 (상수 const라고 보면 된다)
declare -r var1
readonly var1
 
# -i 정수형 타입
declare -i number
number=3
echo "number = $number"     # number = 3
 
# -a 배열 타입
declare -a indices
 
# -A 연관배열(MAP) 타입
declare -A map
 
# -f 함수 타입
declare -f
 
# -x 환경변수(export) 지정
declare -x var3 # 스크립트 외부 환경에서도 이 변수를 쓸 수 있게 해준다.


# 6. 환경변수
# 환경 변수 선언
export hello_world="global hello world"
# 자식 스크립트 호출은 스크립트 경로을 쓰면된다.
/home/export_test.sh
# > 자식스크립트의 코드에서 부모스크립트에서 정의한 hello_world변수값이 출력된다.


# 7. 매개변수

echo "script name : ${0}"
echo "매개변수 갯수 : ${#}"
echo "전체 매개변수 값 : ${*}"
echo "전체 매개변수 값2 : ${@}"
echo "매개변수 1 : ${1}"
echo "매개변수 2 : ${2}"

# ./script.sh 가 나 다 라 마 바 사
# 매개변수 갯수 : 7
# 전체 매개변수 값 : 가 나 다 라 마 바 사
# 전체 매개변수 값2 : 가 나 다 라 마 바 사
# 매개변수 1 : 가
# 매개변수 2 : 나


# 8. 예약변수
# - HOME : 사용자 홈 디렉토리
# - PATH : 실행 파일의 경로,
#   chmod, mkdir 등의 명령어들은 /bin이나 /usr/bin, /sbin에 위치하는데, 
#   이 경로들을 PATH 지정하면 여러분들은 굳이 /bin/chmod를 입력하지 않고, chmod 입력만 해주면 된다.
# - LANG : 프로그램 실행 시 지원되는 언어
# - UID : 사용자의 UID
# - SHELL : 사용자가 로그인시 실행되는 쉘
# - USER : 사용자의 계정 이름
# - FUNCNAME : 현재 실행되고 있는 함수 이름
# - TERM : 로그인 터미널


# 9. 변수 관련 명령어
# set : 셸 변수를 출력하는 명령어
# env : 환경 변수를 출력하는 명령어
# export : 특정 변수의 범위를 환경 변수의 데이터 공간으로 전송하여 자식 프로세스에서도 특정 변수를 사용 가능하게 한다. 전역 변수의 개념
# unset : 선언된 변수를 제거한다.


# 10. 쉘 이스케이프 문자
# \f : 앞 문자열만큼 열을 밀어서 이동
# \n : 새로운 줄로 바꾼다
# \r : 앞 문자열의 앞부분부터 뒷문자열 만큼 대체하고 반환한다.
# \t : 탭 만큼 띄운다.


# 11. 산술연산, expr
number1=10
number2=20
 
plus=`expr $number1 + $number2` 
minus=`expr $number1 - $number2`
mul=`expr $number1 \* $number2` # 곱셈에는 \* 를 이용한다.
div=`expr $number1 / $number2`
rem=`expr $number1 % $number2`
 
echo "plus:     ${plus}"
echo "minus:    ${minus}"
echo "mul:      ${mul}"
echo "div:      ${div}"
echo "rem:      ${rem}"

# 우선순위 산술 연산을 할때는 괄호를 문자 처리해야 한다.
# 연산자 *와 괄호() 앞에는 역슬래시와 같이 사용
num=`expr \( 3 \* 5 \) / 4 + 7`
echo $num


# 12. 산술연산, let
num1=42
num2=9
 
let re=num1+num2 #Add
echo "add:$re"
 
let re=num1-num2 #Sub
echo "sub:$re"
 
let re=num1*num2 #Mul
echo "mul:$re"
 
let re=num1/num2 #Div
echo "div:$re"
 
let re=num1%num2 #Mod
echo "mod:$re"


# 13. 산술연산, $(())
num1=42
num2=9
 
echo add:$((num1+num2))
echo sub:$((num1-num2))
echo mul:$((num1*num2))
echo div:$((num1/num2))
echo mod:$((num1%num2))


# 14. 블록 주석
: << "END"              #주석 시작
echo "여기서부터 "
echo "test_01"
echo "test_02"
echo "test_03"
echo "test_04"
echo "test_05"
echo "test_06"
echo "test_07"
echo "여기까지 주석처리 됨"
END                    #주석 끝
 
echo "여기는 주석이 안되어 있어 출력 "


# 15. if
if [ 값1 조건식 값2 ]
then
    수행1
else
    수행2
fi
 
# 가독성 좋기 위해 then을 if [] 와 붙여쓰려면 반드시 세미콜론 ; 을 써야한다.
if [ 값1 조건식 값2 ]; then
    수행1
else
    수행2
fi

