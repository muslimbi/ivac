
<body onload="backButtonOverride()">
        <form name="OnlineForm" method="post" onsubmit="return verify();" autocomplete="off">
            <table class="visa_table" width="77%">               
                <tbody><tr>
                    <td class="mainHeading" colspan="3"> </td>
                </tr>
                <tr>
                    <td colspan="3" class="text_center">
                        <div class="pageHeading text_center">
                            Appointment Login
                        </div>
                    </td>
                </tr>   

                <tr>
                    <td valign="top" width="100%">
                        <table class="visa_table" width="100%">
                            <tbody><tr>
                                <td>
                                    <div class="cl">
                                        Filenumber
                                    </div>
                                </td>
                                <td>
                                    <input isdatepicker="true" name="fileno" class="textBoxDashed" id="fileno" size="20" maxlength="12" title="Please Enter your Application Id" onkeyup="chkAlphaNum(this)" onblur="trim1(this)" type="text">
                                </td>
                            </tr>
                            <tr>
                                <td><div class="cl">Passport No.  </div></td>
                                <td>
                                    <input isdatepicker="true" name="passport_no" title="Please Enter you Passport No. As in Passport" class="textBoxDashed" id="passport_no" size="20" maxlength="14" onkeyup="chkAlphaNum(this)" onblur="trim1(this);" type="text">
                                </td>
                            </tr>
                            <tr>
                                <td><div class="cl">OTP</div></td>
                                <td>
                                    <input name="otp" title="Please Enter you otp" class="textBoxDashed" id="otp" size="20" maxlength="6" onkeyup="chkAlphaNum(this);
                                            disable_enable_btn()" onblur="trim1(this);" type="password">
                                </td>
                            </tr>
                            <tr>
                                <td><div class="cl">Security Question</div></td>
                                <td>                                             
                                    <img src="QuestionCaptcha.jsp" id="capt" alt="Develped by NIC, New Delhi" height="30" border="0" width="250">
                                    <a href="#" onclick="return refreshCaptcha();"><img src="images/refresh.png" style="width:25px;height:25px"></a>
                                </td> 
                            </tr>


                            <tr>
                                <td><div class="cl">Answer&nbsp;</div></td>
                                <td>
                                    <input isdatepicker="true" name="ImgNum" class="textBoxDashed1" id="ImgNum" onkeyup="chkAlphaNum(this)" size="20" maxlength="20" type="text">
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="cl"> <input name="submit_btn" class="btn btn-primary" value="Submit" id="btn1" onclick="document.OnlineForm.action = 'ProcessApptPwd.jsp'" type="submit"> </div>
                                </td>
                                <td>
                                    <input name="submit_btn" class="btn btn-primary" id="btn2" value="Generate OTP" onclick="document.OnlineForm.action = 'GenerateOTP.jsp'" type="submit">                                     
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" style="text-align: center;font-weight: bold;color:#C61919"><br></td>
                            </tr>

                            <tr>
                                <td colspan="2">
                                    <b>Instructions for appointment</b>
                                    <ul class="instructions_ul text_bold">
                                        <li>Appointment can be booked only after logging in using OTP. </li>                                     
                                        <li>OTP can be generated only after the appointment time starts. </li>     
                                        <li>OTP is valid for 5 minutes.</li>
                                        <li>Maximum 3 OTPs can be generated on a given day for a Filenumber.</li>
					
                                    </ul>
                                </td>
                            </tr>
                        </tbody></table>
                        <br>
                        <br>
                        <br>
                        <br>
                    </td>
                </tr>
            </tbody></table>
        </form>
    
<div style="z-index: 50000; position: absolute; display: none;" id="CalendarPickerControl"></div></body>
