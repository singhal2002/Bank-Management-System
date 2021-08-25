<%@page import="java.util.*" %>
<%
Calendar cal=new GregorianCalendar();
int day=cal.get(Calendar.DATE);
int month=cal.get(Calendar.MONTH)+1;
int year=cal.get(Calendar.YEAR);
String date=day+"-"+month+"-"+year;
String loginid=request.getParameter("loginid");
%>
<html>
<script>
var xmlhttp=null;
function search_accno()
{
try
{
var accno=document.getElementById("accountno_to_search").value;
if(accno.length==0)
return false;
//this ajax query format
var url="ministatement?accountno_to_search="+accno;
//action ? data [name=value & name=value]

xmlhttp=new XMLHttpRequest();
xmlhttp.onreadystatechange=handleServerResponse;
xmlhttp.open("GET",url,true);
xmlhttp.send();
}
catch(e)
{
alert(e);
return false;
}
}

function handleServerResponse()
{
try
{
if(xmlhttp.readyState==4)
{
if(xmlhttp.status==200)
{
//alert(xmlhttp.responseText);
document.getElementById("account_name").value="";
//document.getElementById("account_type").value="";
document.getElementById("balance").value="";
document.getElementById("accno").value="";

var xx, j=0;
var temp;
var x=xmlhttp.responseXML.documentElement.getElementsByTagName("member");
for(var i=0; i<x.length; i++)
{
xx=x[i].getElementsByTagName("name");
var name=xx[0].firstChild.nodeValue;

//xx=x[i].getElementsByTagName("type");
//var type=xx[0].firstChild.nodeValue;

xx=x[i].getElementsByTagName("balance");
var balance=xx[0].firstChild.nodeValue;
xx=x[i].getElementsByTagName("accno");
var accno=xx[0].firstChild.nodeValue;

document.getElementById("account_name").value=name;
//document.getElementById("account_type").value=type;
document.getElementById("balance").value=balance;
document.getElementById("accno").value=accno;
}
/*for(var i=0; i<x.length; i++)*/

var table=document.getElementById("idtable");
var rowCount=table.rows.length;   //this variable holds the length of rows

for(var loop=1;loop<rowCount;loop++)
{
    table.deleteRow(1);
}
var x=xmlhttp.responseXML.documentElement.getElementsByTagName("transaction");
for(var i=0;i<x.length;i++)
{
    xx=x[i].getElementsByTagName("date");
    var date=xx[0].firstChild.nodeValue;

    xx=x[i].getElementsByTagName("time");
    var time=xx[0].firstChild.nodeValue;

    xx=x[i].getElementsByTagName("deposit");
    var deposit=xx[0].firstChild.nodeValue;

    xx=x[i].getElementsByTagName("withdraw");
    var withdraw=xx[0].firstChild.nodeValue;

    xx=x[i].getElementsByTagName("remark");
    if(xx[0].firstChild!=null)
    var remark=xx[0].firstChild.nodeValue;

    tr=document.createElement('tr');
    td=document.createElement('td');
    td.innerHTML=date;
    tr.appendChild(td);

    td=document.createElement('td');
    td.innerHTML=time;
    tr.appendChild(td);

    td=document.createElement('td');
    td.innerHTML=deposit;
    tr.appendChild(td);

    td=document.createElement('td');
    td.innerHTML=withdraw;
    tr.appendChild(td);

    td=document.createElement('td');
    td.innerHTML=remark;
    tr.appendChild(td);

    table.getElementsByTagName("tbody")[0].appendChild(tr);


}
xmlhttp=null;
}
}
}
catch(e)
{ alert(e);
console.log(e);

}
}
</script>
<body>
<table width="100%"><tr><Td align="left">
Welcome <%=loginid%>
</td>
<td align="right"> Date <%=date%></td>
</tr></table>

<div align="center"> MINI Statement </div>

<table align="center" border=1>
<tr><td> Enter Account No. </td>
<td>
<input type="text" onKeyUp="search_accno()" name="accountno_to_search" id="accountno_to_search">
</td>
</tr>
</table>
<br><br><br>
<table align="center">
<tr><td> Account Name </td>
<td> : <input type="text" value="" readonly="true" name="account_name" id="account_name"> </td></tr>
<tr><td> Account Type </td>
<td> : <input type="text" value="" readonly="true" name="account_type" id="account_type"> </td></tr>
<tr><td> Balance </td>
<td> : <input type="text" value="" readonly="true" name="balance" id="balance"> </td></tr>
<tr><td> Account No </td>
<td> : <input type="text" value="" readonly="true" name="accno" id="accno"> </td></tr>
</table>
<br><br>
<table align="center" cellpadding="2" border="1" id="idtable" style="border-collapse:collapse;">
<tbody>
    <tr>
        <td>Date</td>
        <td>Time</td>
        <td>Deposit</td>
        <td>Withdraw</td>
        <td>Remark</td>
    </tr>
</tbody>
</table>
</body>
</html>