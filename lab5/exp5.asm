.386
CODE SEGMENT USE16
ASSUME CS:CODE,DS:CODE
;新的 INT 08H 使用变量

flag DW '#'
;新的 INT 08H 代码
NEW08H PROC FAR

NEW08H ENDP
;取时间子程序 
GET_TIME PROC

GET_TIME ENDP
;初始化（中断处理程序的安装）及主程序 
BEGIN:

MOV SI,BX
SUB SI,2	;获取标记特征位置地址
CMP WORD PTR [SI],'#'	;比较标记特征 
JZ EXIT

MOV AH,02H
MOV DL,'T'
INT 21H	;判断是否重复安装，安装时显示T

MOV DX,OFFSET BEGIN+15
MOV CL,4
SHR DX,CL
ADD DX,10H
MOV AL,0
MOV AH,31H
INT 21H	;中断处理程序驻留
EXIT:
MOV AH,4CH
INT 21H ;退出
CODE ENDS

END BEGIN
