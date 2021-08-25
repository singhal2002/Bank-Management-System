<html>
    <head>
        <script type="text/javascript">
        function onsubmitt()
        {
            return confirm("Are you Sure want to continue");
        }
        </script>
    </head>
    <body>
        <br>
        <br>
        <form method="POST" action="emailid" onsubmit="return onsubmitt()">
        Enter Destination Email-ID
        <input type="text" name="emailid" title="Enter Email-ID to whom message to send">
        <br><br>
        Enter Message to send
        <textarea name="message" rows="5" cols="25"></textarea>
        <input type="submit">
        <br><br>
        <!-- https://www.google.com/settings/security/lesssecureapps       //used for allow the unsecured mails-->
        </form>
    </body>
</html>