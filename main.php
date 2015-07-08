<?php

$code4 = "@echo off \n";
$code4 .= "color 02	\n";
$code4 .= "TITLE IVAC " . $file . "_" . $tmpFileNo . " FINAL \n";
$code4 .= "rem set fileno=xxxxxxxxxxxx\n";
$code4 .= "findstr /r \"<td>BGD*\" ivac".$file."_".$tmpFileNo."-VisaSaveBgd.txt>ivac".$file."_".$tmpFileNo."-temp.txt\n";
$code4 .= "FOR /F \"tokens=2 delims=<td> delims=<\/td>\" %%i IN (ivac".$file."_".$tmpFileNo."-temp.txt) DO (\n";
$code4 .= "SET bgdnumber=%%i\n";
$code4 .= "del ivac".$file."_".$tmpFileNo."-temp.txt\n";
$code4 .= ")\n";
$code4 .= "set fileno=%bgdnumber%\n";
$code4 .= "set APPLNAME=" . $applname . "\n";
$code4 .= "set birthdate=" . $birthdate . "\n";
$code4 .= "set passport_no=" . $passport_no . "\n";
$code4 .= "set aptdate=" . $codedate . "\n";
$code4 .= "set pia=" . $pia . "\n";
$code4 .= "REM set startDate=%date%	\n";
$code4 .= "REM set startTime=%time%	\n";
$code4 .= "set startDate=%date%	\n";
$code4 .= "set startTime=%time%	\n";
$code4 .= "set today=%date:~7,2%/%date:~4,2%/%date:~10,4%\n";
$code4 .= "set /a apd=%date:~7,2%+7\n";
$code4 .= "set APPDATE=%apd%/%date:~4,2%/%date:~10,4%\n";
$code4 .= "\n";
$code4 .= "SET /a ms=%RANDOM%*98/32768+1\n";
$code4 .= "set endTime= 8:42:26.%ms%	\n";
$code4 .= "\n";
$code4 .= ":retry \n";




?>
