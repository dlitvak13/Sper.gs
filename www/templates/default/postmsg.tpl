{include file="header.tpl"}
	<h1>Post Message</h1>
{if isset($p_message)}
	<form action="postmsg.php" method="post">
		<input type="hidden" name="message" value="$p_message" />
    		<input type="hidden" name="h" value="{$token}" />
    		<input type="hidden" name="topic" value="{$topic_id}" />
		{if isset($message_id)}
			<input type="hidden" name="id" value="{$message_id}" />
		{/if}
		<div class="message">
			{$p_message}
		</div>
    		<input type="submit" name="submit" value="Post This Message" />
	</form>
{/if}
	<form action="postmsg.php" method="post">
		<span style="color: #ff0000">
			<b>The rules:</b> Don't be an ass hat. I will ban
		</span>
		<br />
      		<br />
		{if isset($new_topic)}
			To create a new topic, enter a title for the topic below and create the first message.<br />
			<input type="text" name="title" value="" maxlength="80" size="60" /><br />
			(Between 5 and 80 characters in length)<br /><br />
      		{elseif isset($is_link)}
			<b>Current Link:</b> 
			<a href="linkme.php?l={$link_id}" target="_blank">{$link_title}</a><br />
			(Click to open a new window with the current messages)<br />
			<br />
	     		<input type="hidden" name="link" value="{$link_id}" />
		{else}
			<b>Current Topic:</b> 
      			<a href="showmessages.php?topic={$topic_id}&amp;board={$board_id}" target="_blank">{$topic_title}</a><br />
      			(Click to open a new window with the current messages)<br />
      			<br />
     	 		<input type="hidden" name="topic" value="{$topic_id}" />
		{/if}
		{if isset($message_id)}
			<input type="hidden" name="id" value="{$message_id}" />
		{/if}
		<input type="hidden" name="board" value="{$board_id}" /> 
		<b>Your Message</b><br />
		Enter your message text below.<br />
		<textarea cols="100" rows="20" name="message" id="message">
{if isset($e_message)}{$e_message}{elseif isset($quote)}<quote msgid="t,{$quote_topic},{$quote_id}@{$quote_revision}">{$quote_message}</quote>{$signature}{else}{$signature}{/if}</textarea><br />
      <br />

      <div>
        <input type="hidden" name="token" value="{$token}" /> 
        <!--<input type="submit" name="preview" value="Preview Message" /> -->
        <input type="submit" name="submit" value="Post Message" /> 
        <input type="button" id="btn_upload" value="Upload Image" />
     </div>
    </form>
    <div id="uploadFrame" style="display:none;"><iframe id="upload" src= "" width="700" height="300" frameBorder="0"></iframe></div>
    <br />
    <br />
    {include file="footer.tpl"}
  </div>
</body>
</html>
