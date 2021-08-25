<html>
<body>
<br><br>
<form action=createaccount method=post onSubmit="return onsubmitt()" enctype="multipart/form-data">    <!--enctype="multipart/form-data"-->
<table align=center>
<tr><td><h1><b><u>Create New Account</h1></b></u></td></tr>
<tr><td>Enter name: <br>
<input type=text name="name" id=name maxlength=35></td></tr>

<tr><td>Enter Gender: <br>
M:<input type=radio name=gender id=gender_m value=M>
F:<input type=radio name=gender id=gender_f value=F></td></tr>

<tr><td>Enter phone No: <br>
<input type=text name=phoneno id=phoneno maxlength=10></td></tr>

<tr><td>Enter EmailId: <br>
<input type=text name=emailid id=emailid maxlength=50></td></tr>

<tr><td>Enter address: <br>
<textarea name=address id=address rows=5 col=35 maxlength=125></textarea></td></tr>

<tr><td>Enter SSNO/Adhar No: <br>
<input type=text name=ssno id=ssno maxlength=16></td></tr>

<tr><td>Enter PAN No: <br>
<input type=text name=panno id=panno maxlength=10></td></tr>

<tr><td>Enter DOB: <br>
<input type=date name=dob id=dob maxlength=10></td></tr>

<tr><td>Select Qualification: <br>
Int:<input type=checkbox name=intermediate id=intermediate value=intermediate>
Graduation:<input type=checkbox name=graduation id=graduation value=graduation>
Post Graduation:<input type=checkbox name=postgraduation id=postgraduation value=postgraduation></td></tr>

<tr><td>Account Type: <br>
<select name=account_type id=account_type>
<option value="Saving">Saving</option>
<option value="Saving">Current</option></select></td></tr>

<tr>
    <td>
        Select image to upload<input type="file" name="account_image"><br>
    </td>
</tr> 

<tr><td>
<input type=submit value=Register></td></tr>
</table>
</form>

<script>
function onsubmitt(){
	try{   
	    //////////////////validation of Name ////////////////////////
		var name=document.getElementById("name").value;
		if(name.length<3)
		{
			alert("Name Required");
			document.getElementById("name").focus();
			return false;
		}
		if(name.length>35)
		{
			alert("Name input limit exceeds, Max. Character allowed is 35");
			document.getElementById("name").focus();
			return false;
			
		}
		for(var loop=0;loop<name.length;loop++)
		{
		    var ch=name.charAt(loop);
if((ch>='a'&&ch<='z')||(ch>='A'&&ch<='Z') || (ch=='.') || (ch==' '))
{}
else
{
alert("Invalid character in name field");
document.getElementById("name").focus();
			
return false;
}
		}

var new_name="";
        for(var loop=0;loop<name.length;loop++)
            {
                var ch=name.charAt(loop);
                if(loop==0)
                    {
                        if(ch>='a' && ch<='z')
                            {
                                ch=ch.toUpperCase();
                                
                            }
                    }
                else if(ch==' ')
                    {
                        ch=name.charAt(loop+1);
                        if(ch>=' a' && ch<='z')
                            ch=' '+ch.toUpperCase();
                        loop++;
                    }
                new_name=new_name+ch;
            }
        document.getElementById("name").value=new_name;
        
        /////////Validation  for Gender////////////
        
        var is_gender_selected=0;
        var gender_m=document.getElementById("gender_m").checked;
        if(gender_m==true)
            is_gender_selected=1;
        
        var gender_f=document.getElementById("gender_f").checked;
        if(gender_f==true)
            is_gender_selected=1;
        
        if(is_gender_selected==0)
            {
                alert("Gender field is mandatory,Please select gender");
document.getElementById("gender_m").focus();
			
return false;
            }
        
        //////////////Validation for Phone No.//////////
        
        var phoneno=document.getElementById("phoneno").value;
        if(phoneno.length!=10)
            {
                alert("Invalid character, Phone no. length is not 10");
document.getElementById("phoneno").focus();
			return false;
            }
        if(isNaN(phoneno))
            {
                alert("Invalid character, only numbers allowed");
document.getElementById("phoneno").focus();
			return false;
            }
        var ch=phoneno.charAt(0);
        if(ch>='0' && ch<='5')
            {
                alert("First character in phoneno must be greater than 5");
document.getElementById("phoneno").focus();
			return false;
            }
        
        //////////////Validation for emailid//////////
        
        var emailid=document.getElementById("emailid").value;
        if(emailid.length>=50 || emailid.length<8)
            {
                alert("emailid length should be between 0 and 50");
document.getElementById("emailid").focus();
			return false;
            }
        
        var check=/^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
        if(!check.test(emailid))
            {
                alert("Invalid Email-ID");
                return false;
            }
        
        ////////////Validation for Address////////
        
        var address=document.getElementById("address").value;
        if(address.length<10)
            {
                alert("Invalid address, more data required");
document.getElementById("address").focus();
			return false;
            }
        for(var loop=0;loop<address.length;loop++)
            {
                var ch=address.charAt(loop);
                if((ch>='a'&&ch<='z')||(ch>='A'&&ch<='Z') || (ch=='.') || (ch==' ') || (ch>='0' && ch<='9') || (ch=='\n') || (ch==","))
{}
else
{
alert("Invalid character in address field");
document.getElementById("address").focus();
			
return false;
}
}
        //////////Validation for Adhar No./////////
        var ssno=document.getElementById("ssno").value;
        if(ssno.length!=16)
            {
                alert("Invalid character, adhar no. length is not 16");
document.getElementById("ssno").focus();
			return false;
            }
        if(isNaN(ssno))
            {
                alert("Invalid character, only numbers allowed");
document.getElementById("ssno").focus();
			return false;
            }
        
        //////////Validation for PAN No./////////
        
        var panno=document.getElementById("panno").value;
        if(panno.length!=10)
            {
                alert("Invalid character, pan no. length is not 10");
document.getElementById("panno").focus();
			return false;
            }
        var check=/^([a-zA-Z])+([0-9])+([a-zA-Z])+$/;
        if(!check.test(panno))
            {
                alert("Invalid panno");
                return false;
            }
        
        
        ///////////Validation for DOB//////
        var dob=document.getElementById("dob").value;
        if(dob.length<8)
            {
                alert("valid DOB required");
document.getElementById("dob").focus();
			return false;
            }
        var dob_array=new Array();
        dob_array=dob.split("-"); //[2012,07,31]
        if(Number(dob_array[0])<1927)
            {
                alert("Invalid DOB, Greater Year Required");
document.getElementById("dob").focus();
			return false;
            }
        
        //////////validation for qualifications///////////
        var is_qualification_selected=0;
        var intermediate=document.getElementById("intermediate").checked;
        if(intermediate==true)
            {
                is_qualification_selected=1;
            }
        var graduation=document.getElementById("graduation").checked;
        if(graduation==true)
            {
                is_qualification_selected=1;
            }
        var postgraduation=document.getElementById("postgraduation").checked;
        if(postgraduation==true)
            {
                is_qualification_selected=1;
            }
        if(is_qualification_selected==0)
            {
                alert("Qualification is mandatory");
                return false;
            }
        //////////////////////////////////
        
var res=confirm("Are You Sure Want To Register");
if(res==false)
{
	return false;
}

	

}catch(e){
	alert(e);
	console.log(e);
	return false;
	
}
}

</script>



</body>
</html>