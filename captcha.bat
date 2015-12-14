@echo off

SET /a sn=0



:loopagain
SET /a sn+=1

:rand 
set /a try=0
SET /a _rand=%RANDOM%*100/32768+151
SET /a _rand=%RANDOM% %%100 + 151
ECHO ###########################################################################
ECHO ################# Current IP Address in range 151-250=%_rand% #################
ECHO ###########################################################################
SET /a cn=%RANDOM%*8/32768


:tryagain 
set /a try+=1
echo ###################### STEP ONE curl version %cn% IP %_rand% _ time %time% _ TRY : %try% ##################	

c:\curl\curl%cn% -v --trace-time --retry 5 --retry-delay 1 -S --connect-timeout 3 -m 5 -b cookie%sn%.txt -c cookie%sn%.txt --socks5 103.239.6.%_rand%:1020 --proxy-user danteproxy:dantepass --dump-header headers%sn%.txt --user-agent "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:37.0) Gecko/20100101 Firefox/37.0" --referer http://indianvisa-bangladesh.nic.in/visa/Appointment_Login.jsp http://indianvisa-bangladesh.nic.in/visa/Rimage.jsp -o QC%sn%.jpg -w "STEP ONE CAPTCHA Processing on %time% by %try% \n"

if /i %try% EQU 3 SET /a _rand=%RANDOM%*100/32768+151 & set try=0

findstr /L /O /N /C:"Content-Type: text/html" headers%sn%.txt
if /i %ERRORLEVEL% EQU 0 call :captchaenable & goto :tryagain 

findstr /L /O /N /C:"Content-Type: image/jpeg" headers%sn%.txt
if /i %ERRORLEVEL% EQU 0 echo ********************** Error Level is %ERRORLEVEL% for ===STEP ONE=== & goto :captchaAnswer

echo ********************** SERVER BUSY === Retry Again ===STEP ONE===
goto :tryagain

echo ######################
:captchaAnswer
color 03

c:\curl\curl -# -S -F "source_url=" -F "captcha_platform=" -F "action=Submit" -F "file=@QC%sn%.jpg" http://103.239.6.140/gsa_test.gsa -o code%sn%.txt
FOR /F "tokens=11 delims=<\/>" %%i IN (code%sn%.txt) DO del QC%sn%.jpg & SET ImgNum1=%%i

set ajaxCap=a
echo ajaxCap

c:\curl\curl%cn% -# -S --connect-timeout 3 -m 3 -b cookie%sn%.txt -c cookie%sn%.txt --socks5 103.239.6.%_rand%:1020 --proxy-user danteproxy:dantepass -d "iNum=%ImgNum1%" -H "Keep-Alive: 60" -H "Connection: keep-alive" --user-agent "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:37.0) Gecko/20100101 Firefox/37.0" --referer http://indianvisa-bangladesh.nic.in/visa/ http://indianvisa-bangladesh.nic.in/visa/ajaxCap.jsp -o ajaxCap%sn%.txt


FOR /F "tokens=1 delims= " %%a IN (ajaxCap%sn%.txt) DO SET ajaxCap=%%a 
del ajaxCap%sn%.txt

echo ####### STEP ONE ****** Result is %ImgNum1% ****** ajaxCap %ajaxCap% ######################
if %ajaxCap% EQU n goto :rand 
if %ajaxCap% EQU y goto :writecode
if %ajaxCap% EQU a echo SERVER BUSY & goto tryagain


echo ######################
:writecode 
color EC

echo ######################
del headers%sn%.txt
echo ######################  %ImgNum1%  %ajaxCap%  ######################
echo %sn% %ImgNum1% %_rand% %ajaxCap%
echo %sn% %ImgNum1% %_rand% %ajaxCap% > code%sn%.txt

SET /a sn+=1
goto rand





:getFilesize
set filesize=%~z1
exit /b



:captchaenable
echo ************************* captcha enable on time %time% *************************
c:\curl\curl%cn% -v --trace-time --retry 5 --retry-delay 1 -S -m 7 -b cookie%sn%.txt -c cookie%sn%.txt --socks5 103.239.6.%_rand%:1020 --proxy-user danteproxy:dantepass -H "Keep-Alive: 60" -H "Connection: keep-alive" --dump-header headersd%sn%.txt --user-agent "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:37.0) Gecko/20100101 Firefox/37.0" --referer http://indianvisa-bangladesh.nic.in/visa/ReprintAppt.jsp http://indianvisa-bangladesh.nic.in/captcha.gif -o captcha%sn%.gif -w "CAPTCHA ENABLED on %time% by %try% \n" 
echo ************************* captcha done on time %time% *************************

set /a try +=1
if /i %try% EQU 5 SET /a _rand=%RANDOM%*100/32768+151 & set try=0


rem set /p code=Enter Captcha Code:  
c:\curl\curl -v --trace-time -S -b cookie%sn%.txt -c cookie%sn%.txt -H "Keep-Alive: 60" -H "Connection: keep-alive" -F "source_url=" -F "captcha_platform=" -F "action=Submit" -F "file=@captcha%sn%.gif"  --user-agent "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:37.0) Gecko/20100101 Firefox/37.0"   http://103.239.6.141:81/gsa_test.gsa -o gif%sn%.txt  

FOR /F "tokens=11 delims=<\/>" %%l IN (gif%sn%.txt) DO del captcha%sn%.gif & del gif%sn%.txt & SET code2=%%l
set try=0
echo ###################### STEP CAPTCHA ****** Result is %code2% on time %time% ######################	
echo ######################### ====== %code2% ====== #########################


:captchacode
c:\curl\curl%cn% -v --trace-time -i --retry 5 --retry-delay 1 -S -m 5 -b cookie%sn%.txt -c cookie%sn%.txt --socks5 103.239.6.%_rand%:1020 --proxy-user danteproxy:dantepass -H "Keep-Alive: 60" -H "Connection: keep-alive" -d "captcha_resp_txt=%code2%" --dump-header headerse%sn%.txt --user-agent "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:37.0) Gecko/20100101 Firefox/37.0" --referer http://indianvisa-bangladesh.nic.in/visa/ http://indianvisa-bangladesh.nic.in/captcha_resp -w "CAPTCHA DONE on %time% by %try% \n" 
echo ************************* captcha code for captcha_resp on time %time% *************************

set /a try +=1
if /i %try% EQU 50 SET /a _rand=%RANDOM%*100/32768+151 & set try=0 & goto captchaenable

findstr /L /O /N /C:"HTTP/1.1 200 OK" headerse%sn%.txt
if /i %ERRORLEVEL% EQU 0 goto captchaenable

findstr /L /O /N /C:"HTTP/1.1 404 Not Found" headerse%sn%.txt
if /i %ERRORLEVEL% EQU 0 goto captchaenable

findstr /L /O /N /C:"HTTP/1.1 302 Redirect" headerse%sn%.txt
if /i %ERRORLEVEL% EQU 1 goto captchacode

del headersd%sn%.txt
del headerse%sn%.txt

echo ************************* STEP CAPTCHA captcha_resp done on time %time% *************************

exit /b


:EXIT
pause


