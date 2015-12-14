@echo off

rem STEP1:	set try=0, sn=0, cn=curlnumber
rem STEP2:	:loopagain1 -> set sn+=1, if exist code%sn%.txt then copy [ImgNum1, _rand, ajaxCap] then del code%sn%.txt else goto :loopagain1
rem STEP3:	:checktime -> check starttime then goto retry1
rem STEP4:	goto  
rem STEP5:	goto 
rem STEP6:	goto 
rem STEP7:	goto 
rem STEP8:	goto 
rem STEP9:	goto 
rem STEP10:	goto 
rem STEP11:	goto 
rem STEP12:	goto 

set fileno=BGDC77749515
set APPLNAME=MD+SAIFUL
set birthdate=20/04/1983
set passport_no=BB0008360
set aptdate=25/08/2015
set pia=BGDD
set pia1=BGDD1


rem aptdate=today+7days
set aptdate=22/11/2015

set /a try=0
set /a sn=0
SET /a cn=%RANDOM%*8/32768
if exist "%fileno%-headers2.txt" goto :checkretry1

:loopagain1
SET /a sn+=1
IF /i %sn% GTR 100 ( goto :EXIT )
if exist "code%sn%.txt" (
echo Current Serial Number %sn%
FOR /F "tokens=1 delims= " %%a IN (code%sn%.txt) DO SET sn=%%a
FOR /F "tokens=2 delims= " %%b IN (code%sn%.txt) DO SET ImgNum1=%%b
FOR /F "tokens=3 delims= " %%c IN (code%sn%.txt) DO SET _rand=%%c
FOR /F "tokens=4 delims= " %%d IN (code%sn%.txt) DO SET ajaxCap=%%d
del code%sn%.txt
) else ( goto :loopagain1 )

TITLE IVAC %fileno% STEP1 _ IP : %_rand% _ CN : %cn% _ SN:  %sn% _ TRY : %try%
echo ###################### %sn% Current IP Address %_rand% code is %ImgNum1% ajaxCap %ajaxCap% ######################

:checktime 
set startTime=%time%	
SET /a ms=%RANDOM%*98/32768+1
set endTime=11:50:12.%ms%	
	
echo startTime: %startTime%	
echo endTime:   %endTime%	
	
set /a sth=%startTime:~0,2%	
set /a stm=1%startTime:~3,2% - 100	
set /a sts=1%startTime:~6,2% - 100	
	
set /a eth=%endTime:~0,2%	
set /a etm=1%endTime:~3,2% - 100	
set /a ets=1%endTime:~6,2% - 100	
	
set /a lth=0	
set /a ltm=0	
set /a lts=0
	
:CHECK_SEC	
if /i %ets% LSS %sts% goto ROLL_MIN	
set /a lts=%ets% - %sts%	
goto CHECK_MIN	
	
:ROLL_MIN	
set /a stm+=1	
set /a lts=%ets% + 60 - %sts%	
	
:CHECK_MIN	
if /i %etm% LSS %stm% goto ROLL_HOUR	
set /a ltm=%etm% - %stm%	
goto CHECK_HOUR	
	
:ROLL_HOUR	
set /a sth+=1	
set /a ltm=%etm% + 60 - %stm%	
	
:CHECK_HOUR	
if /i %eth% LSS %sth% goto ROLL_DAY	
set /a lth=%eth% - %sth%	
goto DONE	
	
:ROLL_DAY	
set /a lth=%eth% + 24 - %sth%	
	
	
:DONE	
if /i %lts% GTR 59 (	
  set lts%%=60	
  set ltm+=1	
)	
	
if /i %ltm% GTR 59 (	
  set ltm%%=60	
  set lth+=1	
)	
	
echo Lapsed hours:   %lth%	
echo Lapsed minutes: %ltm%	
echo Lapsed seconds: %lts%	
set /a tls = %lth% * 60 * 60 + %ltm% * 60 + %lts%	
	
	
if /i %tls% GTR 16000 goto :retry1
	
echo Total Lapsed Seconds: %tls%	
	
	
timeout %tls%	
goto :retry1	
echo ************************* Technical Problem ***************************** >> %fileno%-report.txt	




:retry1
color 02
SET /a try+=1
TITLE IVAC %fileno% STEP1 _ IP : %_rand% _ CN : %cn% _ SN:  %sn% _ TRY : %try%
echo ###################### STEP ONE.ONE curl version %cn% IP %_rand% _ time %time% _ SN:  %sn% _  TRY : %try% ################## >> %fileno%-report.txt	
c:\curl\curl%cn% -v --trace-time --retry 5 --retry-delay 1 -S --connect-timeout 3 -m 5 -b cookie%sn%.txt -c cookie%sn%.txt --socks5 103.239.6.%_rand%:1080 --proxy-user danteproxy:dantepass -d "ImgNum=%ImgNum1%&fileno=%fileno%&otp=&passport_no=%passport_no%&submit_btn=Generate%20OTP" -H "Keep-Alive: 60" -H "Connection: keep-alive" --dump-header %fileno%-headers2.txt --user-agent "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:37.0) Gecko/20100101 Firefox/37.0" --referer http://indianvisa-bangladesh.nic.in/visa/Appointment_Login.jsp http://indianvisa-bangladesh.nic.in/visa/GenerateOTP.jsp -w "STEP ONE.ONE GenerateOTP Processing on %time% by %try% \n" 2>> %fileno%-report.txt	
echo ********************** STEP ONE.ONE ****** Done by IP %_rand% _ time %time% _ SN:  %sn% _  TRY : %try% ************************* >> %fileno%-report.txt	
echo *********************************************************************************************** >> %fileno%-report.txt	

findstr /L /O /N /C:"HTTP/1.1 200 OK" %fileno%-headers2.txt
if /i %ERRORLEVEL% EQU 0 goto :loopagain1 

findstr /L /O /N /C:"HTTP/1.1 404 Not Found" %fileno%-headers2.txt
if /i %ERRORLEVEL% EQU 0 goto :loopagain1 

findstr /L /O /N /C:"HTTP/1.1 302 Moved Temporarily" %fileno%-headers2.txt
if /i %ERRORLEVEL% EQU 0 echo ********************** Error Level is %ERRORLEVEL% for ===Generated OTP=== & goto :checkretry1 

echo ********************** SERVER BUSY === Retry Again ===STEP ONE.ONE=== >> %fileno%-report.txt
if /i %try% EQU 100 set try=0 & goto :loopagain1
goto :retry1
echo ************************* Technical Problem ***************************** >> %fileno%-report.txt	

:checkretry1
findstr /L /O /N /C:"Invalid Answer" %fileno%-headers2.txt
if /i %ERRORLEVEL% EQU 0 echo ======   Error Level is %ERRORLEVEL% for ===Invalid Answer=== & goto :loopagain1 

findstr /L /O /N /C:"No more otp can be generated today for this application ID" %fileno%-headers2.txt
if /i %ERRORLEVEL% EQU 0 echo ======   Error Level is %ERRORLEVEL% for ===No more otp=== can be generated today for this application ID & goto :EXIT

findstr /L /O /N /C:"OTP can be generated only after appointment time starts" %fileno%-headers2.txt
if /i %ERRORLEVEL% EQU 0 echo ======   Error Level is %ERRORLEVEL% for ===OTP can be generated only after appointment time starts=== & timeout 2 & goto :loopagain1

findstr /L /O /N /C:"Invalid filenumber or OTP" %fileno%-headers2.txt
if /i %ERRORLEVEL% EQU 0 echo ======   Error Level is %ERRORLEVEL% for ===Invalid filenumber or OTP=== & goto :EXIT

findstr /r "%fileno%" %fileno%-headers2.txt>%fileno%-headers2-temp.txt
echo ********************** Error Level is %ERRORLEVEL% in Generated OTP >> %fileno%-report.txt
if /i %ERRORLEVEL% EQU 1 goto :loopagain1  
FOR /F "usebackq tokens=10" %%p IN (%fileno%-headers2-temp.txt) DO (
SET bgdnumber=%%p
del %fileno%-headers2-temp.txt
)

echo ********************** "%bgdnumber%" **********************
set otp=%bgdnumber:~0,6%
echo ********** Time= %time% ********** "%otp%" **********
echo ********************** Time= %time% ********************* OTP= %otp% ************************* >> %fileno%-report.txt	
echo ###################### STEP ONE *END* *END* *END* *END* ###################### >> %fileno%-report.txt	
echo ###################### STEP ONE *END* *END* *END* *END* ###################### >> %fileno%-report.txt	
echo ###################### STEP ONE *END* *END* *END* *END* ###################### >> %fileno%-report.txt	
echo.>> %fileno%-report.txt	
echo.>> %fileno%-report.txt	
echo.>> %fileno%-report.txt	
echo.>> %fileno%-report.txt	
echo.>> %fileno%-report.txt	
goto :retry2 
echo ************************* Technical Problem ***************************** >> %fileno%-report.txt	


===============================================================================================================================================
===============================================================================================================================================
===============================================================================================================================================
===============================================================================================================================================


:retry2
color E1
set /a try=0
set /a sn=0

:loopagain2
SET /a sn+=1
echo Current %sn%
IF /i %sn% GTR 500 ( goto :EXIT )
if exist "code%sn%.txt" (
echo Current Serial Number %sn%
FOR /F "tokens=1 delims= " %%a IN (code%sn%.txt) DO SET sn=%%a
FOR /F "tokens=2 delims= " %%b IN (code%sn%.txt) DO SET ImgNum2=%%b
FOR /F "tokens=3 delims= " %%c IN (code%sn%.txt) DO SET _rand=%%c
FOR /F "tokens=4 delims= " %%d IN (code%sn%.txt) DO SET ajaxCap=%%d
del code%sn%.txt
) else ( goto :loopagain2 )

TITLE IVAC %fileno% STEP2 _ IP : %_rand% _ CN : %cn% _ SN:  %sn% _ TRY : %try%
echo ###################### %sn% Current IP Address %_rand% code is %ImgNum2% ajaxCap %ajaxCap% ######################

:retry22
color EC
SET /a try+=1
TITLE IVAC %fileno% STEP2 _ IP : %_rand% _ CN : %cn% _ SN:  %sn% _ TRY : %try%
echo ###################### STEP TWO.TWO curl version %cn% IP %_rand% _ time %time% _ SN:  %sn% _  TRY : %try% ################## >> %fileno%-report.txt	
c:\curl\curl%cn% -v --trace-time --retry 5 --retry-delay 1 -S --connect-timeout 3 -m 5 -b cookie%sn%.txt -c %fileno%_cookie.txt --socks5 103.239.6.%_rand%:1080 --proxy-user danteproxy:dantepass -d "ImgNum=%ImgNum2%&fileno=%fileno%&otp=%otp%&passport_no=%passport_no%&submit_btn=Submit" -H "Keep-Alive: 60" -H "Connection: keep-alive" --dump-header %fileno%-headers4.txt --user-agent "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:37.0) Gecko/20100101 Firefox/37.0" --referer http://indianvisa-bangladesh.nic.in/visa/Appointment_Home.jsp http://indianvisa-bangladesh.nic.in/visa/ProcessApptPwd.jsp -w "STEP TWO.TWO ProcessApptPwd Processing on %time% by %try% \n" 2>> %fileno%-report.txt	
echo ********************** STEP TWO.TWO ****** Done by IP %_rand% _ time %time% _ SN:  %sn% _  TRY : %try% ************************* >> %fileno%-report.txt	
echo *********************************************************************************************** >> %fileno%-report.txt	

findstr /L /O /N /C:"HTTP/1.1 200 OK" %fileno%-headers4.txt
if /i %ERRORLEVEL% EQU 0 goto :loopagain2 

findstr /L /O /N /C:"HTTP/1.1 302 Moved Temporarily" %fileno%-headers4.txt
if /i %ERRORLEVEL% EQU 0 echo ======   Error Level is %ERRORLEVEL% for ===Captcha OK=== & goto :checkretry22 

echo ********************** SERVER BUSY === Retry Again ===STEP TWO.TWO=== >> %fileno%-report.txt
if /i %try% EQU 100 set try=0 & goto :loopagain2
goto :retry22
echo ************************* Technical Problem ***************************** >> %fileno%-report.txt	


:checkretry22
findstr /L /O /N /C:"Invalid Answer" %fileno%-headers4.txt
if /i %ERRORLEVEL% EQU 0 echo ======   Error Level is %ERRORLEVEL% for Invalid Answer & goto :loopagain2 

findstr /L /O /N /C:"Invalid OTP" %fileno%-headers4.txt
if /i %ERRORLEVEL% EQU 0 echo ======   Error Level is %ERRORLEVEL% for Invalid Answer & goto :loopagain2 

findstr /L /O /N /C:"Please generate OTP" %fileno%-headers4.txt
if /i %ERRORLEVEL% EQU 0 echo ======   Error Level is %ERRORLEVEL% for Please generate OTP & goto :loopagain1 

findstr /r "Appointment_Home" %fileno%-headers4.txt
echo ********************** Error Level is %ERRORLEVEL% in Appointment Home >> %fileno%-report.txt
del %fileno%-headers2.txt
echo ###################### STEP TWO *END* *END* *END* *END* ###################### >> %fileno%-report.txt	
echo ###################### STEP TWO *END* *END* *END* *END* ###################### >> %fileno%-report.txt	
echo ###################### STEP TWO *END* *END* *END* *END* ###################### >> %fileno%-report.txt	
echo.>> %fileno%-report.txt	
echo.>> %fileno%-report.txt	
echo.>> %fileno%-report.txt	
echo.>> %fileno%-report.txt	
echo.>> %fileno%-report.txt	

set /a try=0
if /i %ERRORLEVEL% EQU 0 goto :retry3


===============================================================================================================================================
===============================================================================================================================================
===============================================================================================================================================
===============================================================================================================================================



:retry3
color 21 
TITLE IVAC %fileno% STEP3 _ IP : %_rand% _ CN : %cn% _ TRY : %try%

echo ###################### STEP THREE curl version %cn% IP %_rand% _ time %time% _ SN:  %sn% _  TRY : %try% ################## >> %fileno%-report.txt	
c:\curl\curl%cn% -v --trace-time --retry 5 --retry-delay 1 -S --connect-timeout 3 -m 5 -b %fileno%_cookie.txt -c %fileno%_cookie.txt --socks5 103.239.6.%_rand%:1080 --proxy-user danteproxy:dantepass --dump-header %fileno%-headers5.txt --user-agent "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:37.0) Gecko/20100101 Firefox/37.0" --referer http://indianvisa-bangladesh.nic.in/visa/Appointment_Login.jsp http://indianvisa-bangladesh.nic.in/visa/Rimage.jsp -o %fileno%_QC3.jpg -w "STEP THREE CAPTCHA Processing on %time% by %try% \n" 2>> %fileno%-report.txt
echo ********************** STEP THREE ****** Done by IP %_rand% _ time %time% _ SN:  %sn% _  TRY : %try% ************************* >> %fileno%-report.txt	

rem set /a try +=1
rem if /i %try% EQU 20 SET /a _rand=%RANDOM%*100/32768+151 & set try=0

findstr /L /O /N /C:"Content-Type: text/html" %fileno%-headers5.txt
if /i %ERRORLEVEL% EQU 0 call :captchaenable & goto :retry3 

findstr /L /O /N /C:"Content-Type: image/jpeg" %fileno%-headers5.txt
if /i %ERRORLEVEL% EQU 0 echo **********************   Error Level is %ERRORLEVEL% for ===STEP THREE=== & goto :captchaAnswer3 

echo ********************** SERVER BUSY === Retry Again ===STEP THREE=== >> %fileno%-report.txt
goto :retry3
echo ************************* Technical Problem ***************************** >> %fileno%-report.txt	


:captchaAnswer3
color 29
echo ####### Start QC3 on time %time% ####### %ImgNum1% ####### %ImgNum2% ####### %ImgNum3% ####### %ImgNum% ####### >> %fileno%-report.txt
c:\curl\curl -S -F "source_url=" -F "captcha_platform=" -F "action=Submit" -F "file=@%fileno%_QC3.jpg" http://103.239.6.140/gsa_test.gsa -o %fileno%-code.txt
FOR /F "tokens=11 delims=<\/>" %%k IN (%fileno%-code.txt) DO SET ImgNum3=%%k
echo ####### End QC3 on time %time% ####### %ImgNum1% ####### %ImgNum2% ####### %ImgNum3% ####### %ImgNum% ####### >> %fileno%-report.txt

set try=0

:retry33
color 2A
echo ###################### STEP THREE.THREE curl version %cn% IP %_rand% _ time %time% _ SN:  %sn% _  TRY : %try% ################## >> %fileno%-report.txt	
c:\curl\curl%cn% -v --trace-time --retry 5 --retry-delay 1 -S --connect-timeout 3 -m 15 -b %fileno%_cookie.txt -c %fileno%_cookie.txt --socks5 103.239.6.%_rand%:1080 --proxy-user danteproxy:dantepass -d "ImgNum=%ImgNum3%&birthdate=%birthdate%&fileno=%fileno%&passport_no=%passport_no%&pia=%pia1%&submit_btn=Submit" --dump-header %fileno%-headers6.txt --user-agent "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:37.0) Gecko/20100101 Firefox/37.0" --referer http://indianvisa-bangladesh.nic.in/visa/Appointment_Home.jsp http://indianvisa-bangladesh.nic.in/visa/ReprintAppt.jsp -o %fileno%-ReprintAppt.txt -w "STEP THREE.THREE Appointment_Home Processing on %time% by %try% \n" 2>> %fileno%-report.txt	
echo ************************* STEP THREE.THREE ****** Done by IP %_rand% _ time %time% _ SN:  %sn% _  TRY : %try% ************************* >> %fileno%-report.txt	
echo *********************************************************************************************** >> %fileno%-report.txt	

rem set /a try +=1
rem if /i %try% EQU 20 SET /a _rand=%RANDOM%*100/32768+151 & set try=0

findstr /L /O /N /C:"HTTP/1.1 200 OK" %fileno%-headers6.txt
if /i %ERRORLEVEL% EQU 0 echo ********************** Error Level is %ERRORLEVEL% for 200===Appointment_Home=== & goto :checkretry200 

findstr /L /O /N /C:"HTTP/1.1 302 Moved Temporarily" %fileno%-headers6.txt
if /i %ERRORLEVEL% EQU 0 echo ********************** Error Level is %ERRORLEVEL% for 302===Appointment_Home=== & goto :checkretry302 

echo ********************** SERVER BUSY === Retry Again ===STEP THREE.THREE=== >> %fileno%-report.txt
goto :retry33


:checkretry302
findstr /L /O /N /C:"Invalid Captcha" %fileno%-headers6.txt
if /i %ERRORLEVEL% EQU 0 echo ======   Error Level is %ERRORLEVEL% for ===Invalid Answer=== & del %fileno%_QC3.jpg & goto :loopagain1 

findstr /L /O /N /C:"Your OTP is expired" %fileno%-headers6.txt
if /i %ERRORLEVEL% EQU 0 echo ======   Error Level is %ERRORLEVEL% for ===Invalid Answer=== & goto :loopagain1 

findstr /r "Appointment_Login" %fileno%-headers6.txt
if /i %ERRORLEVEL% EQU 0 goto :loopagain1

findstr /r "no_appointment_dates" %fileno%-headers6.txt
if /i %ERRORLEVEL% EQU 0 goto :retry33



:checkretry200
findstr /L /O /N /C:"The Problem may be due to 500 Server Error/404 Page Not Found.Please contact your system administrator" %fileno%-ReprintAppt.txt
if /i %ERRORLEVEL% EQU 0 echo ======   Error Level is %ERRORLEVEL% for ===The Problem may be due to 500 Server Error/404 Page Not Found.Please contact your system administrator=== & goto EXIT

findstr /L /O /N /C:"New Appointment is possible only" %fileno%-ReprintAppt.txt
if /i %ERRORLEVEL% EQU 0 echo ======   Error Level is %ERRORLEVEL% for ===New Appointment is possible only within 5 days of Registration's Date=== & goto EXIT

findstr /L /O /N /C:"Appointment Date is already taken" %fileno%-ReprintAppt.txt
if /i %ERRORLEVEL% EQU 0 echo ======   Error Level is %ERRORLEVEL% for ===Appointment Date is already taken=== & goto EXIT

findstr /L /O /N /C:"Access code is not valid" %fileno%-ReprintAppt.txt
if /i %ERRORLEVEL% EQU 0 echo ======   Error Level is %ERRORLEVEL% for ===Access code is not valid=== & goto EXIT

findstr /L /O /N /C:"Connection: Close" %fileno%-headers6.txt
if /i %ERRORLEVEL% EQU 0 call :captchaenable & goto :retry33

findstr /r "Transfer-Encoding: chunked" %fileno%-headers6.txt
if /i %ERRORLEVEL% EQU 0 goto final



=============================================================================================


:getFilesize
set filesize=%~z1
exit /b



:captchaenable
echo ************************* captcha enable on time %time% ************************* >> %fileno%-report.txt
c:\curl\curl%cn% -v --trace-time --retry 5 --retry-delay 1 -S -m 5 -b %fileno%_cookie.txt -c %fileno%_cookie.txt --socks5 103.239.6.%_rand%:1080 --proxy-user danteproxy:dantepass -H "Keep-Alive: 60" -H "Connection: keep-alive" --dump-header %fileno%-headers7.txt --user-agent "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:37.0) Gecko/20100101 Firefox/37.0" --referer http://indianvisa-bangladesh.nic.in/visa/ReprintAppt.jsp http://indianvisa-bangladesh.nic.in/captcha.gif -o %fileno%-captcha.gif -w "CAPTCHA ENABLED on %time% by %try% \n" 2>> %fileno%-report.txt
echo ************************* captcha done on time %time% ************************* >> %fileno%-report.txt	

rem set /a try +=1
rem if /i %try% EQU 5 SET /a _rand=%RANDOM%*100/32768+151 & set try=0


rem set /p code=Enter Captcha Code:  
c:\curl\curl -v --trace-time -S -b %fileno%_cookie.txt -c %fileno%_cookie.txt -H "Keep-Alive: 60" -H "Connection: keep-alive" -F "source_url=" -F "captcha_platform=" -F "action=Submit" -F "file=@%fileno%-captcha.gif"  --dump-header %fileno%-headers8.txt --user-agent "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:37.0) Gecko/20100101 Firefox/37.0"   http://103.239.6.141:81/gsa_test.gsa -o %fileno%-gif.txt  

FOR /F "tokens=11 delims=<\/>" %%l IN (%fileno%-gif.txt) DO del %fileno%-captcha.gif & SET code2=%%l
set try=0
echo ###################### STEP CAPTCHA ****** Result is %code2% on time %time% ###################### >> %fileno%-report.txt	
echo ######################### ====== %code2% ====== #########################


:captchacode
c:\curl\curl%cn% -v --trace-time -i --retry 5 --retry-delay 1 -S -m 5 -b %fileno%_cookie.txt -c %fileno%_cookie.txt --socks5 103.239.6.%_rand%:1080 --proxy-user danteproxy:dantepass -H "Keep-Alive: 60" -H "Connection: keep-alive" -d "captcha_resp_txt=%code2%" --dump-header %fileno%-headers9.txt --user-agent "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:37.0) Gecko/20100101 Firefox/37.0" --referer http://indianvisa-bangladesh.nic.in/visa/ http://indianvisa-bangladesh.nic.in/captcha_resp -o %fileno%-captcha.done -w "CAPTCHA DONE on %time% by %try% \n" 2>> %fileno%-report.txt	
echo ************************* captcha code for captcha_resp on time %time% ************************* >> %fileno%-report.txt	

rem set /a try +=1
rem if /i %try% EQU 20 SET /a _rand=%RANDOM%*100/32768+151 & set try=0 & goto captchaenable

findstr /L /O /N /C:"HTTP/1.1 200 OK" %fileno%-headers9.txt
if /i %ERRORLEVEL% EQU 0 goto captchaenable

findstr /L /O /N /C:"HTTP/1.1 404 Not Found" %fileno%-headers9.txt
if /i %ERRORLEVEL% EQU 0 goto captchaenable

findstr /L /O /N /C:"HTTP/1.1 302 Redirect" %fileno%-headers9.txt
if /i %ERRORLEVEL% EQU 1 goto captchacode

echo ************************* STEP CAPTCHA captcha_resp done on time %time% ************************* >> %fileno%-report.txt	
echo ************************* STEP CAPTCHA captcha_resp done on time %time% ************************* >> %fileno%-report.txt	

exit /b



:final
color A9 
TITLE IVAC %fileno% FINAL _ IP : %_rand% _ CN : %cn% _ TRY : %try%

SET /a cn=%RANDOM%*8/32768
echo curl version %cn%

c:\curl\curl%cn% -v --trace-time -S --connect-timeout 3 -m 5 -b %fileno%_cookie.txt -c %fileno%_cookie.txt --socks5 103.239.6.%_rand%:1080 --proxy-user danteproxy:dantepass --dump-header %fileno%-headers11.txt --user-agent "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:37.0) Gecko/20100101 Firefox/37.0" --referer http://indianvisa-bangladesh.nic.in/visa/ReprintAppt.jsp http://indianvisa-bangladesh.nic.in/visa/Rimage.jsp -o %fileno%-captcha.jpg -w "STEP FINAL CAPTCHA Processing on %time% by %try% \n" 2>> %fileno%-report.txt
echo ********************** STEP FINAL ****** Done by IP %_rand% _ time %time% _ SN:  %sn% _  TRY : %try% ************************* >> %fileno%-report.txt	

rem set /a try +=1
rem if /i %try% EQU 20 SET /a _rand=%RANDOM%*100/32768+151 & set try=0

findstr /L /O /N /C:"Content-Type: text/html" %fileno%-headers11.txt
if /i %ERRORLEVEL% EQU 0 call :captchaenable & goto :final 

findstr /L /O /N /C:"Content-Type: image/jpeg" %fileno%-headers11.txt
if /i %ERRORLEVEL% EQU 0 echo **********************   Error Level is %ERRORLEVEL% for ===STEP FINAL=== & goto :retrivecode 

echo ********************** SERVER BUSY === Retry Again ===STEP FINAL=== >> %fileno%-report.txt
goto :final

:retrivecode 
color A4
echo ####### Start FC on time %time% ####### %ImgNum1% ####### %ImgNum2% ####### %ImgNum3% ####### %ImgNum% ####### >> %fileno%-report.txt
c:\curl\curl -S -F "source_url=" -F "captcha_platform=" -F "action=Submit" -F "file=@%fileno%-captcha.jpg" http://103.239.6.140/gsa_test.gsa -o %fileno%-code.txt
FOR /F "tokens=11 delims=<\/>" %%m IN (%fileno%-code.txt) DO del %fileno%-captcha.jpg & SET ImgNum=%%m
echo ####### End FC on time %time% ####### %ImgNum1% ####### %ImgNum2% ####### %ImgNum3% ####### %ImgNum% ####### >> %fileno%-report.txt

set try=0


:postdata 
color 09 
TITLE IVAC %fileno% POSTDATA _ IP : %_rand% _ CN : %cn% _ TRY : %try%

set /a try +=1 
 
echo =================== IP:  %_rand% =================== Retry: %try% =================== >> %fileno%-report.txt	
	
echo curl version %cn%

c:\curl\curl%cn%  -v --trace-time -S -m 8 -b %fileno%_cookie.txt -c %fileno%_cookie.txt --socks5 103.239.6.%_rand%:1080 --proxy-user danteproxy:dantepass -d "fileno=%fileno%&APPLNAME=%APPLNAME%&PIA=%pia%&next_page=Visa_print_Form2.jsp&DATE=%aptdate%&ImgNum=%ImgNum%&SAVE=Confirm+The+Appointment" --dump-header %fileno%-headers12.txt --user-agent "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:37.0) Gecko/20100101 Firefox/37.0" --referer http://indianvisa-bangladesh.nic.in/visa/ReprintAppt.jsp http://indianvisa-bangladesh.nic.in/visa/allotmentsave.jsp -o %fileno%-allotmentsave.txt 2>> %fileno%-report.txt	
 
rem set /a try +=1
rem if /i %try% EQU 20 SET /a _rand=%RANDOM%*100/32768+151 & set try=0

findstr /L /O /N /C:"HTTP/1.1 200 OK" %fileno%-headers12.txt
if /i %ERRORLEVEL% EQU 0 echo ********************** Error Level is %ERRORLEVEL% for 200===allotmentsave=== & goto :checkfinal200 

findstr /L /O /N /C:"HTTP/1.1 302 Moved Temporarily" %fileno%-headers12.txt
if /i %ERRORLEVEL% EQU 0 echo ********************** Error Level is %ERRORLEVEL% for 302===allotmentsave=== & goto :checkfinal302 

echo ********************** SERVER BUSY === Retry Again ===STEP POSTDATA=== >> %fileno%-report.txt
goto :postdata

:checkfinal302
findstr /L /O /N /C:"Invalid Captcha" %fileno%-headers12.txt
if /i %ERRORLEVEL% EQU 0 echo ======   Error Level is %ERRORLEVEL% for ===Invalid Answer=== & goto EXIT 


findstr /r "indianVisaReg" %fileno%-headers12.txt
if /i %ERRORLEVEL% EQU 0 goto EXIT

findstr /r "Visa_print_Form2.jsp?number=%fileno%" %fileno%-headers12.txt
if /i %ERRORLEVEL% EQU 0 goto EXIT



:checkfinal200
findstr /L /O /N /C:"Connection: Close" %fileno%-headers12.txt
if /i %ERRORLEVEL% EQU 0 call :captchaenable & goto :postdata

 
	
:EXIT	
echo =================== *********************************************** =================== >> %fileno%-report.txt	
echo =================== ************* END OF CURL EXECUTE ************* =================== >> %fileno%-report.txt	
echo =================== *********************************************** =================== >> %fileno%-report.txt	
echo. >> %fileno%-report.txt	
echo. >> %fileno%-report.txt	
echo Sucess 
pause
rem start %fileno%_bgdfinal.bat 	
