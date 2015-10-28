proc Tvar(m:string,n:var string) = 
  n = n & "a"
  #discard
var 
  #refvar2: ref string
  var1 = "yrs"
  var2 = "abc"
  refvar2: ref string

echo "var1 = ",var1
echo repr(var1)

new refvar2
refvar2 = cast[ref string](addr(var2))
echo repr(refvar2)

echo repr(var1)
echo "var1 = ",var1


#该程序的问题是：程序始终没有对var1进行任何的改变，但是会出现异常结果，如下面0.11.2版本所示。
#在0.11.2版本中，上面程序中把过程Tvar去掉，会显示正常的结果，这个Tvar过程与下面的程序无关。
#或者把refvar2 的声明放在var1的上面，也会出现正常结果。
#在0.12.0版本中是正常的结果，如下面0.12.0版本所示。

#########################################
#在0.11.2版本出现的结果
discard """
var1 = yrs
00000000002CC050"yrs"
ref 000000000042F128 --> 00000000002CC078"abc"

00000000002CC058"\8\0\0\0\0\0\0"
var1 =
"""

#########################################
#0.12.0版本正常结果：
discard """
var1 = yrs
ref 000000000042F118 --> 000000000054C078"abc"

000000000054C050"yrs"
var1 = yrs
"""

