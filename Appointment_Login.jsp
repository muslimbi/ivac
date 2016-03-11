


<!DOCTYPE HTML>
<html>
    <head>
        <link href="css/Online_regular.css" rel="stylesheet" type="text/css"/>
        <script language="javaScript" type="text/javascript" src="validate.js"></script>
        <title>Appointment Login</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <noscript>
        <meta http-equiv="refresh" content="0; URL=Error.jsp">
    </noscript>
    <script type="text/javascript" src="datepickercontrol.js"></script>
    <link type="text/css" rel="stylesheet" href="datepickercontrol.css">
    <script language="javaScript" type="text/javascript" src="validate.js"></script>
    <script language="javaScript" type="text/javascript" src="js/jquery.js"></script>
    

    <script>
        function verify() {         
            var i = document.OnlineForm.action.lastIndexOf("/");
            var t = document.OnlineForm.action.substring(i + 1, document.OnlineForm.action.length);
            var f1=document.getElementsByClassName('app_field')[0].value;
            var f2=document.getElementsByClassName('app_field')[1].value;


            if (isEmpty(document.OnlineForm.fileno.value)) {
                alert("Please Enter Application Id");
                document.OnlineForm.fileno.focus();
                return false;
            }

            else if (isEmpty(document.OnlineForm.passport_no.value)) {
                alert("Please Enter Passport No.");
                document.OnlineForm.passport_no.focus();
                return false;
            }
            else if (f1==null||f1.value==""||isEmpty(f1))
            {
                alert("Please Enter All mandtory fields");
                //document.OnlineForm.f1.focus();
                return false;

            }
            else if (f2==null||f2.value==""||isEmpty(f2))
            {
                alert("Please Enter All mandtory fields");
                //document.OnlineForm.f2.focus();
                return false;
            }
            else if (isEmpty(document.OnlineForm.otp.value) && t == "ProcessApptPwd.jsp") {
                alert("Please Enter OTP.");
                document.OnlineForm.otp.focus();
                return false;
            }
            else if (isEmpty(document.OnlineForm.ImgNum.value)) {
                alert("Please Enter Answer");
                document.OnlineForm.ImgNum.focus();
                return false;
            }


            return true;
        }

        function refreshCaptcha()
        {
            try
            {
                var d = new Date();
                var n = d.getTime();
                //document.getElementById("capt").src="images/1.jpg";
                //alert("hi");
                document.getElementById("capt").src = "QuestionCaptcha.jsp?rand=" + n;
            }
            catch (e)
            {
                alert(e);
            }
            return false;
        }
        function disable_enable_btn() {
            var t = document.getElementById("otp").value;
            if (t.length == 6) {
                document.getElementById("btn2").disabled = true;
                document.getElementById("btn1").disabled = false;
            }
            else if (t.length < 6) {
                document.getElementById("btn2").disabled = false;
                document.getElementById("btn1").disabled = true;
            }
        }
    </script>
    
</head>
<body onLoad="backButtonOverride()">
    <form name="OnlineForm" method="post"   onSubmit="return verify();" autocomplete="off">
        <table width="77%" class="visa_table">
            <tr>
                <td class="mainHeading" colspan="3" > </td>
            </tr>
            <tr>
                <td colspan="3" class="text_center">
                    <div class="pageHeading text_center">
                        Appointment Login
                    </div>
                </td>
            </tr>

            <tr>
                <td width="100%" valign="top">
                    <table width="100%" class="visa_table">
                        <tr>
                            <td>
                                <div class="cl">
                                    Filenumber
                                </div>
                            </td>
                            <td>
                                <input name="fileno"  type="text" class="textBoxDashed"  id="fileno"  size="20" maxlength="12" title="Please Enter your Application Id"  onKeyUp="chkAlphaNum(this)"  onBlur="trim1(this)"/>
                            </td>
                        </tr>
                        <tr>
                            <td><div class="cl">Passport No.</div></td>
                            <td>
                                <input name="passport_no"  type="text" title="Please Enter you Passport No. As in Passport" class="textBoxDashed"  id="passport_no" size="20" maxlength="14"  onKeyUp="chkAlphaNum(this)" onBlur='trim1(this);'/>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="cl">
                                    Father's Name
                                </div></td>
                            <td>
                                <input name="874116"  type="text" class="textBoxDashed app_field"  size="20" maxlength="50"  onKeyUp="chkString(this)" onBlur='trim1(this);'/>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="cl">
                                    Birth Place
                                </div></td>
                            <td>
                                <input name="205329"  type="text" class="textBoxDashed app_field"  size="20" maxlength="50"  onKeyUp="chkString(this)" onBlur='trim1(this);'/>
                            </td>
                        </tr>
                        <tr>
                            <td><div class="cl">OTP</div></td>
                            <td>
                                <input name="otp" type="password" title="Please Enter your otp" class="textBoxDashed"  id="otp" size="20" maxlength="6"  onKeyUp="chkAlphaNum(this);
                                       disable_enable_btn()" onBlur='trim1(this);'/>
                            </td>
                        </tr>
                        <tr>
                            <td><div class="cl">Security Question</div></td>
                            <td>
                                <img src="QuestionCaptcha.jsp" id="capt" alt="Develped by NIC, New Delhi" width="250" height="30" border="0" >
                                <a href="#"  onclick="return refreshCaptcha();"><img src="images/refresh.png" style="width:25px;height:25px"/></a>
                            </td>
                        </tr>


                        <tr>
                            <td><div class="cl">Answer&nbsp;</div></td>
                            <td>
                                <input name="ImgNum" type="text" class="textBoxDashed1" id="ImgNum" onKeyUp="chkAlphaNum(this)" size="20" maxlength="20">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="cl"> <input name="submit_btn" type="submit" class="btn btn-primary"  value="Submit" id="btn1" onclick="document.OnlineForm.action = 'ProcessApptPwd.jsp'"> </div>
                            </td>
                            <td>
                                <input name="submit_btn" type="submit" class="btn btn-primary" id="btn2" value="Generate OTP" onclick="document.OnlineForm.action = 'GenerateOTP.jsp'">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="text-align: center;font-weight: bold;color:#C61919"><BR></td>
                        </tr>

                        <tr>
                            <td colspan="2">
                                <B>Instructions for appointment</B>
                                <ul class="instructions_ul text_bold">
                                    <li>Appointment can be booked only after logging in using OTP. </li>
                                    <li>OTP can be generated only after the appointment time starts. </li>
                                    <li>OTP is valid for 5 minutes.</li>
                                    <li>Maximum 3 OTPs can be generated on a given day for a File Number.</li>
                                </ul>
                            </td>
                        </tr>
                    </table>
                    <BR>
                    <BR>
                    <BR>
                    <BR>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
