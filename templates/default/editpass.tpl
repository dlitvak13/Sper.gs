<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta name="generator" content=
  "HTML Tidy for Linux/x86 (vers 11 February 2007), see www.w3.org" />

  <title>{$sitename} - Edit Profile</title>
  <link rel="icon" href="//static.endoftheinter.net/images/dealwithit.ico" type=
  "image/x-icon" />
  <link rel="apple-touch-icon-precomposed" href=
  "//static.endoftheinter.net/images/apple-touch-icon-ipad.png" />
  <link rel="stylesheet" type="text/css" href=
  "templates/default/css/nblue.css?18" />
  <script type="text/javascript" src="/templates/default/js/base.js?27">
</script>
</head>

<body class="regular">
  <div class="body">
	{include file="navigation.tpl"}

    <div style=
    "position:fixed;z-index:999;background:red;width:1px;height:1px;bottom:45px!important;bottom:10000px;right:24px">
    <!--a reminder, for all that we fought against. -->
    </div>

    <h1>Edit Profile</h1>
{foreach $message as $msg}
<h2><em>{$msg}</em></h2>
{/foreach}<br />
    <form action="editpass.php" method="post" autocomplete="off">
      <table class="grid">
        <tr>
          <th colspan="2">Change Password for {$username}</th>
        </tr>

        <tr>
          <td>Confirm Your Current Password</td>

          <td><input type="password" name="old" size="30" /></td>
        </tr>

        <tr>
          <td>Enter A New Password</td>

          <td><input type="password" name="new" size="30" /></td>
        </tr>

        <tr>
          <td>Confirm Your New Password</td>

          <td><input type="password" name="new2" size="30" /></td>
        </tr>

        <tr>
          <td colspan="2"><input type="submit" name="go" value="Make Changes" /></td>
        </tr>
      </table>
    </form><br />
    <br />
	{include file="footer.tpl"}
  </div>
</body>
</html>