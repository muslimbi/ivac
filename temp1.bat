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
echo Current %sn%
IF /i %sn% GTR 500 ( goto :EXIT )
if exist "code%sn%.txt" (
FOR /F "tokens=1 delims= " %%a IN (code%sn%.txt) DO SET sn=%%a
FOR /F "tokens=2 delims= " %%b IN (code%sn%.txt) DO SET ImgNum1=%%b
FOR /F "tokens=3 delims= " %%c IN (code%sn%.txt) DO SET _rand=%%c
FOR /F "tokens=4 delims= " %%d IN (code%sn%.txt) DO SET ajaxCap=%%d
del code%sn%.txt
) else ( goto :loopagain1 )


echo ###################### %sn% Current IP Address %_rand% code is %ImgNum1% ajaxCap %ajaxCap% ######################

:checktime 
set startTime=%time%	
SET /a ms=%RANDOM%*98/32768+1
set endTime=11:44:08.%ms%	
	
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
	
	
if /i %tls% GTR 16000 goto :checkretry1  
	
echo Total Lapsed Seconds: %tls%	
	
	
timeout %tls%	
goto retry1	




:retry1
color 02
echo ###################### STEP ONE.ONE curl version %cn% IP %_rand% _ time %time% _ TRY : %try% ################## >> %fileno%-report.txt	
c:\curl\curl%cn% -v --trace-time --retry 5 --retry-delay 1 -S --connect-timeout 3 -m 5 -b cookie%sn%.txt -c %fileno%_cookie.txt --socks5 103.239.6.%_rand%:1080 --proxy-user danteproxy:dantepass -d "ImgNum=%ImgNum1%&fileno=%fileno%&otp=&passport_no=%passport_no%&submit_btn=Generate%20OTP" -H "Keep-Alive: 60" -H "Connection: keep-alive" --dump-header %fileno%-headers2.txt --user-agent "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:37.0) Gecko/20100101 Firefox/37.0" --referer http://indianvisa-bangladesh.nic.in/visa/Appointment_Login.jsp http://indianvisa-bangladesh.nic.in/visa/GenerateOTP.jsp -w "STEP ONE.ONE GenerateOTP Processing on %time% by %try% \n" 2>> %fileno%-report.txt	
echo ********************** STEP ONE.ONE ****** Done by IP %_rand% _ time %time% _ TRY : %try% ************************* >> %fileno%-report.txt	
echo *********************************************************************************************** >> %fileno%-report.txt	

set /a try +=1
if /i %try% EQU 50 SET /a _rand=%RANDOM%*100/32768+151 & set try=0

findstr /L /O /N /C:"HTTP/1.1 200 OK" %fileno%-headers2.txt
if /i %ERRORLEVEL% EQU 0 call :captchaenable & goto :retry1 

findstr /L /O /N /C:"HTTP/1.1 302 Moved Temporarily" %fileno%-headers2.txt
if /i %ERRORLEVEL% EQU 0 echo ********************** Error Level is %ERRORLEVEL% for ===Generated OTP=== & goto :checkretry1 

echo ********************** SERVER BUSY === Retry Again ===STEP ONE.ONE=== >> %fileno%-report.txt
goto :retry1
echo *************************#################################***************************** >> %fileno%-report.txt	

:checkretry1
findstr /L /O /N /C:"Invalid Answer" %fileno%-headers2.txt
if /i %ERRORLEVEL% EQU 0 echo ======   Error Level is %ERRORLEVEL% for ===Invalid Answer=== & goto :loopagain1 

findstr /L /O /N /C:"No more otp can be generated today for this application ID" %fileno%-headers2.txt
if /i %ERRORLEVEL% EQU 0 echo ======   Error Level is %ERRORLEVEL% for ===No more otp=== can be generated today for this application ID & goto EXIT

findstr /L /O /N /C:"OTP can be generated only after appointment time starts" %fileno%-headers2.txt
if /i %ERRORLEVEL% EQU 0 echo ======   Error Level is %ERRORLEVEL% for ===OTP can be generated only after appointment time starts=== & timeout 2 & goto loopagain1

findstr /L /O /N /C:"Invalid filenumber or OTP" %fileno%-headers2.txt
if /i %ERRORLEVEL% EQU 0 echo ======   Error Level is %ERRORLEVEL% for ===Invalid filenumber or OTP=== & timeout 10 & goto loopagain1

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
echo *************************#################################***************************** >> %fileno%-report.txt	


===============================================================================================================================================
===============================================================================================================================================
===============================================================================================================================================
===============================================================================================================================================


:retry2
color E1 
TITLE IVAC %fileno% STEP2 _ IP : %_rand% _ CN : %cn% _ TRY : %try%

:loopagain2
SET /a sn+=1
echo Current %sn%
IF /i %sn% GTR 500 ( goto :EXIT )
if exist "code%sn%.txt" (
FOR /F "tokens=1 delims= " %%a IN (code%sn%.txt) DO SET sn=%%a
FOR /F "tokens=2 delims= " %%b IN (code%sn%.txt) DO SET ImgNum2=%%b
FOR /F "tokens=3 delims= " %%c IN (code%sn%.txt) DO SET _rand=%%c
FOR /F "tokens=4 delims= " %%d IN (code%sn%.txt) DO SET ajaxCap=%%d
del code%sn%.txt
) else ( goto :loopagain2 )

echo ###################### %sn% Current IP Address %_rand% code is %ImgNum2% ajaxCap %ajaxCap% ######################

:retry22
color EC
echo ###################### STEP TWO.TWO curl version %cn% IP %_rand% _ time %time% _ TRY : %try% ################## >> %fileno%-report.txt	
c:\curl\curl%cn% -v --trace-time --retry 5 --retry-delay 1 -S --connect-timeout 3 -m 5 -b cookie%sn%.txt -c %fileno%_cookie.txt --socks5 103.239.6.%_rand%:1080 --proxy-user danteproxy:dantepass -d "ImgNum=%ImgNum2%&fileno=%fileno%&otp=%otp%&passport_no=%passport_no%&submit_btn=Submit" -H "Keep-Alive: 60" -H "Connection: keep-alive" --dump-header %fileno%-headers4.txt --user-agent "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:37.0) Gecko/20100101 Firefox/37.0" --referer http://indianvisa-bangladesh.nic.in/visa/Appointment_Home.jsp http://indianvisa-bangladesh.nic.in/visa/ProcessApptPwd.jsp -w "STEP TWO.TWO ProcessApptPwd Processing on %time% by %try% \n" 2>> %fileno%-report.txt	
echo ********************** STEP TWO.TWO ****** Done by IP %_rand% _ time %time% _ TRY : %try% ************************* >> %fileno%-report.txt	
echo *********************************************************************************************** >> %fileno%-report.txt	

set /a try +=1
if /i %try% EQU 50 SET /a _rand=%RANDOM%*100/32768+151 & set try=0

findstr /L /O /N /C:"HTTP/1.1 200 OK" %fileno%-headers4.txt
if /i %ERRORLEVEL% EQU 0 call :captchaenable & goto :retry22 

findstr /L /O /N /C:"HTTP/1.1 302 Moved Temporarily" %fileno%-headers4.txt
if /i %ERRORLEVEL% EQU 0 echo ======   Error Level is %ERRORLEVEL% for ===Captcha OK=== & goto :checkretry22 

echo ********************** SERVER BUSY === Retry Again ===STEP TWO.TWO=== >> %fileno%-report.txt
goto :retry22

:checkretry22
findstr /L /O /N /C:"Invalid Answer" %fileno%-headers4.txt
if /i %ERRORLEVEL% EQU 0 echo ======   Error Level is %ERRORLEVEL% for Invalid Answer & goto retry2 

findstr /r "Appointment_Home" %fileno%-headers4.txt
echo ********************** Error Level is %ERRORLEVEL% in Appointment Home >> %fileno%-report.txt
echo ###################### STEP TWO *END* *END* *END* *END* ###################### >> %fileno%-report.txt	
echo ###################### STEP TWO *END* *END* *END* *END* ###################### >> %fileno%-report.txt	
echo ###################### STEP TWO *END* *END* *END* *END* ###################### >> %fileno%-report.txt	
echo.>> %fileno%-report.txt	
echo.>> %fileno%-report.txt	
echo.>> %fileno%-report.txt	
echo.>> %fileno%-report.txt	
echo.>> %fileno%-report.txt	

if /i %ERRORLEVEL% EQU 0 goto retry3


===============================================================================================================================================
===============================================================================================================================================
===============================================================================================================================================
===============================================================================================================================================



:retry3
color 21 
TITLE IVAC %fileno% STEP3 _ IP : %_rand% _ CN : %cn% _ TRY : %try%

echo ###################### STEP THREE curl version %cn% IP %_rand% _ time %time% _ TRY : %try% ################## >> %fileno%-report.txt	
c:\curl\curl%cn% -v --trace-time --retry 5 --retry-delay 1 -S --connect-timeout 3 -m 5 -b %fileno%_cookie.txt -c %fileno%_cookie.txt --socks5 103.239.6.%_rand%:1080 --proxy-user danteproxy:dantepass --dump-header %fileno%-headers5.txt --user-agent "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:37.0) Gecko/20100101 Firefox/37.0" --referer http://indianvisa-bangladesh.nic.in/visa/Appointment_Login.jsp http://indianvisa-bangladesh.nic.in/visa/Rimage.jsp -o %fileno%_QC3.jpg -w "STEP THREE CAPTCHA Processing on %time% by %try% \n" 2>> %fileno%-report.txt
echo ********************** STEP THREE ****** Done by IP %_rand% _ time %time% _ TRY : %try% ************************* >> %fileno%-report.txt	

set /a try +=1
if /i %try% EQU 50 SET /a _rand=%RANDOM%*100/32768+151 & set try=0

findstr /L /O /N /C:"Content-Type: text/html" %fileno%-headers5.txt
if /i %ERRORLEVEL% EQU 0 call :captchaenable & goto :retry3 

findstr /L /O /N /C:"Content-Type: image/jpeg" %fileno%-headers5.txt
if /i %ERRORLEVEL% EQU 0 echo **********************   Error Level is %ERRORLEVEL% for ===STEP THREE=== & goto :captchaAnswer3 

echo ********************** SERVER BUSY === Retry Again ===STEP THREE=== >> %fileno%-report.txt
goto :retry3


:captchaAnswer3
color 29
echo ####### Start QC3 on time %time% ####### %ImgNum1% ####### %ImgNum2% ####### %ImgNum3% ####### %ImgNum% ####### >> %fileno%-report.txt
c:\curl\curl -S -F "source_url=" -F "captcha_platform=" -F "action=Submit" -F "file=@%fileno%_QC3.jpg" http://103.239.6.140/gsa_test.gsa -o %fileno%-code.txt
FOR /F "tokens=11 delims=<\/>" %%k IN (%fileno%-code.txt) DO del %fileno%_QC3.jpg & SET ImgNum3=%%k
echo ####### End QC3 on time %time% ####### %ImgNum1% ####### %ImgNum2% ####### %ImgNum3% ####### %ImgNum% ####### >> %fileno%-report.txt

set try=0
set ajaxCap=a

:captchaAnswer3check
c:\curl\curl%cn% -v --trace-time -S -m 7 -b %fileno%_cookie.txt -c %fileno%_cookie.txt --socks5 103.239.6.%_rand%:1080 --proxy-user danteproxy:dantepass -d "iNum=%ImgNum3%" -H "Keep-Alive: 60" -H "Connection: keep-alive" --dump-header %fileno%-headers17.txt --user-agent "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:37.0) Gecko/20100101 Firefox/37.0" --referer http://indianvisa-bangladesh.nic.in/visa/ http://indianvisa-bangladesh.nic.in/visa/ajaxCap.jsp -o %fileno%_ajaxCap.txt

set /a try +=1
if /i %try% EQU 50 goto retry3

if exist "%fileno%_ajaxCap.txt" ( 
FOR /F "tokens=1 delims= " %%c IN (%fileno%_ajaxCap.txt) DO SET ajaxCap=%%c 
del %fileno%_ajaxCap.txt
)

echo ####### STEP THREE ****** Result is %ImgNum3% ajaxCap %ajaxCap% ###################### >> %fileno%-report.txt

if %ajaxCap% EQU n goto retry3

if %ajaxCap% EQU y echo Captcha YES

if %ajaxCap% EQU a echo SERVER BUSY & goto :captchaAnswer3check

echo ###################### ====== %ImgNum3% ====== %ajaxCap% ====== ######################


:retry33
color 2A
echo ###################### STEP THREE.THREE curl version %cn% IP %_rand% _ time %time% _ TRY : %try% ################## >> %fileno%-report.txt	
c:\curl\curl%cn% -v --trace-time --retry 5 --retry-delay 1 -S --connect-timeout 3 -m 15 -b %fileno%_cookie.txt -c %fileno%_cookie.txt --socks5 103.239.6.%_rand%:1080 --proxy-user danteproxy:dantepass -d "ImgNum=%ImgNum3%&birthdate=%birthdate%&fileno=%fileno%&pia=%pia1%&submit_btn=Submit" --dump-header %fileno%-headers6.txt --user-agent "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:37.0) Gecko/20100101 Firefox/37.0" --referer http://indianvisa-bangladesh.nic.in/visa/Appointment_Home.jsp http://indianvisa-bangladesh.nic.in/visa/Appointment_Passport.jsp -w "STEP THREE.THREE Appointment_Home Processing on %time% by %try% \n" 2>> %fileno%-report.txt	
echo ************************* STEP THREE.THREE ****** Done by IP %_rand% _ time %time% _ TRY : %try% ************************* >> %fileno%-report.txt	
echo *********************************************************************************************** >> %fileno%-report.txt	

set /a try +=1
if /i %try% EQU 50 SET /a _rand=%RANDOM%*100/32768+151 & set try=0

findstr /L /O /N /C:"HTTP/1.1 200 OK" %fileno%-headers6.txt
if /i %ERRORLEVEL% EQU 0 call :captchaenable & goto :retry33

findstr /L /O /N /C:"HTTP/1.1 302 Moved Temporarily" %fileno%-headers6.txt
if /i %ERRORLEVEL% EQU 0 echo ********************** Error Level is %ERRORLEVEL% for ===Appointment_Home=== & goto :checkretry33 

echo ********************** SERVER BUSY === Retry Again ===STEP ONE.ONE=== >> %fileno%-report.txt
goto :retry33


:checkretry33
findstr /L /O /N /C:"Invalid Answer" %fileno%-headers6.txt
if /i %ERRORLEVEL% EQU 0 echo ======   Error Level is %ERRORLEVEL% for ===Invalid Answer=== & goto retry1
 
findstr /L /O /N /C:"Invalid Captcha" %fileno%-headers6.txt
if /i %ERRORLEVEL% EQU 0 echo ======   Error Level is %ERRORLEVEL% for ===Invalid Answer=== & goto retry1 


findstr /r "Appointment_Login" %fileno%-headers6.txt
if /i %ERRORLEVEL% EQU 0 goto retry1

findstr /r "no_appointment_dates" %fileno%-headers6.txt
if /i %ERRORLEVEL% EQU 0 goto EXIT

findstr /r "Appointment_Home" %fileno%-headers6.txt
if /i %ERRORLEVEL% EQU 0 goto final


=============================================================================================
===============================================================================================================================================
===============================================================================================================================================
===============================================================================================================================================
===============================================================================================================================================



:retry3
color 21 
TITLE IVAC %fileno% STEP3 _ IP : %_rand% _ CN : %cn% _ TRY : %try%

echo ###################### STEP THREE curl version %cn% IP %_rand% _ time %time% _ TRY : %try% ################## >> %fileno%-report.txt	
c:\curl\curl%cn% -v --trace-time --retry 5 --retry-delay 1 -S --connect-timeout 3 -m 5 -b %fileno%_cookie.txt -c %fileno%_cookie.txt --socks5 103.239.6.%_rand%:1080 --proxy-user danteproxy:dantepass --dump-header %fileno%-headers5.txt --user-agent "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:37.0) Gecko/20100101 Firefox/37.0" --referer http://indianvisa-bangladesh.nic.in/visa/Appointment_Login.jsp http://indianvisa-bangladesh.nic.in/visa/Rimage.jsp -o %fileno%_QC3.jpg -w "STEP THREE CAPTCHA Processing on %time% by %try% \n" 2>> %fileno%-report.txt
echo ********************** STEP THREE ****** Done by IP %_rand% _ time %time% _ TRY : %try% ************************* >> %fileno%-report.txt	

set /a try +=1
if /i %try% EQU 50 SET /a _rand=%RANDOM%*100/32768+151 & set try=0

findstr /L /O /N /C:"Content-Type: text/html" %fileno%-headers5.txt
if /i %ERRORLEVEL% EQU 0 call :captchaenable & goto :retry3 

findstr /L /O /N /C:"Content-Type: image/jpeg" %fileno%-headers5.txt
if /i %ERRORLEVEL% EQU 0 echo **********************   Error Level is %ERRORLEVEL% for ===STEP THREE=== & goto :captchaAnswer3 

echo ********************** SERVER BUSY === Retry Again ===STEP THREE=== >> %fileno%-report.txt
goto :retry3


:captchaAnswer3
color 29
echo ####### Start QC3 on time %time% ####### %ImgNum1% ####### %ImgNum2% ####### %ImgNum3% ####### %ImgNum% ####### >> %fileno%-report.txt
c:\curl\curl -S -F "source_url=" -F "captcha_platform=" -F "action=Submit" -F "file=@%fileno%_QC3.jpg" http://103.239.6.140/gsa_test.gsa -o %fileno%-code.txt
FOR /F "tokens=11 delims=<\/>" %%k IN (%fileno%-code.txt) DO del %fileno%_QC3.jpg & SET ImgNum3=%%k
echo ####### End QC3 on time %time% ####### %ImgNum1% ####### %ImgNum2% ####### %ImgNum3% ####### %ImgNum% ####### >> %fileno%-report.txt

set try=0
set ajaxCap=a

:captchaAnswer3check
c:\curl\curl%cn% -v --trace-time -S -m 7 -b %fileno%_cookie.txt -c %fileno%_cookie.txt --socks5 103.239.6.%_rand%:1080 --proxy-user danteproxy:dantepass -d "iNum=%ImgNum3%" -H "Keep-Alive: 60" -H "Connection: keep-alive" --dump-header %fileno%-headers17.txt --user-agent "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:37.0) Gecko/20100101 Firefox/37.0" --referer http://indianvisa-bangladesh.nic.in/visa/ http://indianvisa-bangladesh.nic.in/visa/ajaxCap.jsp -o %fileno%_ajaxCap.txt

set /a try +=1
if /i %try% EQU 50 goto retry3

if exist "%fileno%_ajaxCap.txt" ( 
FOR /F "tokens=1 delims= " %%c IN (%fileno%_ajaxCap.txt) DO SET ajaxCap=%%c 
del %fileno%_ajaxCap.txt
)

echo ####### STEP THREE ****** Result is %ImgNum3% ajaxCap %ajaxCap% ###################### >> %fileno%-report.txt

if %ajaxCap% EQU n goto retry3

if %ajaxCap% EQU y echo Captcha YES

if %ajaxCap% EQU a echo SERVER BUSY & goto :captchaAnswer3check

echo ###################### ====== %ImgNum3% ====== %ajaxCap% ====== ######################


:retry33
color 2A
echo ###################### STEP THREE.THREE curl version %cn% IP %_rand% _ time %time% _ TRY : %try% ################## >> %fileno%-report.txt	
c:\curl\curl%cn% -v --trace-time --retry 5 --retry-delay 1 -S --connect-timeout 3 -m 15 -b %fileno%_cookie.txt -c %fileno%_cookie.txt --socks5 103.239.6.%_rand%:1080 --proxy-user danteproxy:dantepass -d "ImgNum=%ImgNum3%&fileno=%fileno%&passport_no=%passport_no%&submit_btn=Submit" --dump-header %fileno%-headers6.txt --user-agent "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:37.0) Gecko/20100101 Firefox/37.0" --referer http://indianvisa-bangladesh.nic.in/visa/Appointment_Passport.jsp http://indianvisa-bangladesh.nic.in/visa/ReprintAppt.jsp -w "STEP THREE.THREE Appointment_Home Processing on %time% by %try% \n" 2>> %fileno%-report.txt	
echo ************************* STEP THREE.THREE ****** Done by IP %_rand% _ time %time% _ TRY : %try% ************************* >> %fileno%-report.txt	
echo *********************************************************************************************** >> %fileno%-report.txt	

set /a try +=1
if /i %try% EQU 50 SET /a _rand=%RANDOM%*100/32768+151 & set try=0

findstr /L /O /N /C:"HTTP/1.1 200 OK" %fileno%-headers6.txt
if /i %ERRORLEVEL% EQU 0 call :captchaenable & goto :retry33

findstr /L /O /N /C:"HTTP/1.1 302 Moved Temporarily" %fileno%-headers6.txt
if /i %ERRORLEVEL% EQU 0 echo ********************** Error Level is %ERRORLEVEL% for ===Appointment_Home=== & goto :checkretry33 

echo ********************** SERVER BUSY === Retry Again ===STEP ONE.ONE=== >> %fileno%-report.txt
goto :retry33


:checkretry33
findstr /L /O /N /C:"Invalid Answer" %fileno%-headers6.txt
if /i %ERRORLEVEL% EQU 0 echo ======   Error Level is %ERRORLEVEL% for ===Invalid Answer=== & goto retry1
 
findstr /L /O /N /C:"Invalid Captcha" %fileno%-headers6.txt
if /i %ERRORLEVEL% EQU 0 echo ======   Error Level is %ERRORLEVEL% for ===Invalid Answer=== & goto retry1 


findstr /r "Appointment_Login" %fileno%-headers6.txt
if /i %ERRORLEVEL% EQU 0 goto retry1

findstr /r "no_appointment_dates" %fileno%-headers6.txt
if /i %ERRORLEVEL% EQU 0 goto EXIT

findstr /r "Appointment_Home" %fileno%-headers6.txt
if /i %ERRORLEVEL% EQU 0 goto final


:getFilesize
set filesize=%~z1
exit /b



:captchaenable
echo ************************* captcha enable on time %time% ************************* >> %fileno%-report.txt
c:\curl\curl%cn% -v --trace-time --retry 5 --retry-delay 1 -S -m 7 -b %fileno%_cookie.txt -c %fileno%_cookie.txt --socks5 103.239.6.%_rand%:1080 --proxy-user danteproxy:dantepass -H "Keep-Alive: 60" -H "Connection: keep-alive" --dump-header %fileno%-headers7.txt --user-agent "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:37.0) Gecko/20100101 Firefox/37.0" --referer http://indianvisa-bangladesh.nic.in/visa/ReprintAppt.jsp http://indianvisa-bangladesh.nic.in/captcha.gif -o %fileno%-captcha.gif -w "CAPTCHA ENABLED on %time% by %try% \n" 2>> %fileno%-report.txt
echo ************************* captcha done on time %time% ************************* >> %fileno%-report.txt	

set /a try +=1
if /i %try% EQU 50 SET /a _rand=%RANDOM%*100/32768+151 & set try=0


rem set /p code=Enter Captcha Code:  
c:\curl\curl -v --trace-time -S -b %fileno%_cookie.txt -c %fileno%_cookie.txt -H "Keep-Alive: 60" -H "Connection: keep-alive" -F "source_url=" -F "captcha_platform=" -F "action=Submit" -F "file=@%fileno%-captcha.gif"  --dump-header %fileno%-headers8.txt --user-agent "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:37.0) Gecko/20100101 Firefox/37.0"   http://103.239.6.141:81/gsa_test.gsa -o %fileno%-gif.txt  

FOR /F "tokens=11 delims=<\/>" %%l IN (%fileno%-gif.txt) DO del %fileno%-captcha.gif & SET code2=%%l
set try=0
echo ###################### STEP CAPTCHA ****** Result is %code2% on time %time% ###################### >> %fileno%-report.txt	
echo ######################### ====== %code2% ====== #########################


:captchacode
c:\curl\curl%cn% -v --trace-time -i --retry 5 --retry-delay 1 -S -m 5 -b %fileno%_cookie.txt -c %fileno%_cookie.txt --socks5 103.239.6.%_rand%:1080 --proxy-user danteproxy:dantepass -H "Keep-Alive: 60" -H "Connection: keep-alive" -d "captcha_resp_txt=%code2%" --dump-header %fileno%-headers9.txt --user-agent "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:37.0) Gecko/20100101 Firefox/37.0" --referer http://indianvisa-bangladesh.nic.in/visa/ http://indianvisa-bangladesh.nic.in/captcha_resp -o %fileno%-captcha.done -w "CAPTCHA DONE on %time% by %try% \n" 2>> %fileno%-report.txt	
echo ************************* captcha code for captcha_resp on time %time% ************************* >> %fileno%-report.txt	

set /a try +=1
if /i %try% EQU 50 SET /a _rand=%RANDOM%*100/32768+151 & set try=0 & goto captchaenable

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
echo ********************** STEP FINAL ****** Done by IP %_rand% _ time %time% _ TRY : %try% ************************* >> %fileno%-report.txt	

set /a try +=1
if /i %try% EQU 50 SET /a _rand=%RANDOM%*100/32768+151 & set try=0

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
set ajaxCap=a

:captchaAnswerFinalcheck
c:\curl\curl%cn% -v --trace-time -S -m 7 -b %fileno%_cookie.txt -c %fileno%_cookie.txt --socks5 103.239.6.%_rand%:1080 --proxy-user danteproxy:dantepass -d "iNum=%ImgNum%" -H "Keep-Alive: 60" -H "Connection: keep-alive" --dump-header %fileno%-headers18.txt --user-agent "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:37.0) Gecko/20100101 Firefox/37.0" --referer http://indianvisa-bangladesh.nic.in/visa/ http://indianvisa-bangladesh.nic.in/visa/ajaxCap.jsp -o %fileno%_ajaxCap.txt

if exist "%fileno%_ajaxCap.txt" ( 
call :getFilesize "%fileno%_ajaxCap.txt" 
FOR /F "tokens=1 delims= " %%d IN (%fileno%_ajaxCap.txt) DO SET ajaxCap=%%d 
del %fileno%_ajaxCap.txt
)

if /i %fileSize% EQU 1017 ( call :captchaenable & goto captchaAnswerFinalcheck ) 

echo ####### STEP FINAL ****** Result is %ImgNum% ajaxCap %ajaxCap% ###################### >> %fileno%-report.txt

if %ajaxCap% EQU n goto final

if %ajaxCap% EQU y echo Captcha YES

if %ajaxCap% EQU a echo SERVER BUSY & goto :captchaAnswerFinalcheck

echo ###################### ====== %ImgNum% ====== %ajaxCap% ====== ######################
 

:postdata 
color 09 
TITLE IVAC %fileno% POSTDATA _ IP : %_rand% _ CN : %cn% _ TRY : %try%

set /a try +=1 
 
echo =================== IP:  %_rand% =================== Retry: %try% =================== >> %fileno%-report.txt	
	
echo curl version %cn%

c:\curl\curl%cn%  -v --trace-time -S -m 8 -b %fileno%_cookie.txt -c %fileno%_cookie.txt --socks5 103.239.6.%_rand%:1080 --proxy-user danteproxy:dantepass -d "fileno=%fileno%&APPLNAME=%APPLNAME%&PIA=%pia%&next_page=Visa_print_Form2.jsp&DATE=%aptdate%&ImgNum=%ImgNum%&SAVE=Confirm+The+Appointment" --dump-header log\%fileno%-header-%try%.txt --user-agent "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:37.0) Gecko/20100101 Firefox/37.0" --referer http://indianvisa-bangladesh.nic.in/visa/ReprintAppt.jsp http://indianvisa-bangladesh.nic.in/visa/allotmentsave.jsp -o %fileno%-allotmentsave.txt 2>> %fileno%-report.txt	
 
set /a try +=1

IF /i %try% GTR 50 ( goto :EXIT )

if exist "%fileno%-allotmentsave.txt" ( call :getFilesize "%fileno%-allotmentsave.txt" ) else ( goto postdata )

if /i %fileSize% EQU 1017 ( call :captchaenable & goto postdata ) else ( goto postdata )
 
echo =================== *********************************************** =================== >> %fileno%-report.txt	
echo =================== ************* END OF CURL EXECUTE ************* =================== >> %fileno%-report.txt	
echo =================== *********************************************** =================== >> %fileno%-report.txt	
echo. >> %fileno%-report.txt	
echo. >> %fileno%-report.txt	
 
	
:EXIT	
echo Sucess 
pause
rem start %fileno%_bgdfinal.bat 	
