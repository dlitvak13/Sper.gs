{include file="header.tpl"}
	<h1>{$board_title}</h1>
	<h2>{$topic_title}</h2>
	{if isset($status_message) && $status_message != NULL}<br /><h3 style="text-align:center"><em>{$status_message}</em></h3><br />{/if}
	<div class="userbar">
		<a href="./profile.php?user={$user_id}">{$username} ({$karma})</a>: 
		<span id="userbar_pms" style="display:none">
			<a href="./inbox.php">Private Messages (<span id="userbar_pms_count">0</span>)</a> |
		</span>
		<!--<a href="./boardlist.php">Board List</a> | -->
      	<a href="./showtopics.php?board=42">Topic List</a> | 
		<a href="./postmsg.php?board={$board_id}&amp;topic={$topic_id}">Post New Message</a>
		<!--| <a href="//boards.endoftheinter.net/showmessages.php?board=42&amp;topic=7758474&amp;h=76f03" onclick="return !tagTopic(this, 7758474, true)">Tag</a> | 
		<a href="//wiki.endoftheinter.net/index.php/Help:Rules">Help</a>-->
		{if $action != NULL} 
			| <a href="./showmessages.php?board={$board_id}&amp;topic={$topic_id}&amp;sticky=1&amp;token={$token}" onclick="confirm('Are you sure you want to pin this topic?');">
				{$action[0].name}
			</a>
		{/if}
	</div>
{literal}
	<script type="text/javascript">
		//<![CDATA[
		//onDOMContentLoaded(function(){new PrivateMessageManager($("userbar_pms"), $("userbar_pms_count"), ["72057594037945962",0])})
		//]]>
	</script>
{/literal}
	<div class="infobar" id="u0_2">
		{if $current_page > 1} <span><a href="./showmessages.php?board=42&amp;topic={$topic_id}&amp;page=1">First Page</a> |</span>{/if}
		{if $current_page > 2}<span><a href="./showmessages.php?board=42&amp;topic={$topic_id}&amp;page={$current_page - 1}">Prev Page</a> |</span>{/if}
		Page {$current_page} of <span>{$page_count}</span> 
		{if $current_page < $page_count - 1}<span>| <a href="./showmessages.php?board=42&amp;topic={$topic_id}&amp;page={$current_page + 1}">Next Page</a></span> {/if}
		{if $current_page < $page_count}<span>| <a href="./showmessages.php?board=42&amp;topic={$topic_id}&amp;page={$page_count}">Last Page</a></span>{/if}
	</div>
	<div id="u0_1">
{$i=5}
{foreach from=$messages key=header item=table}
	<div class="message-container" id="m{$table.message_id}">
		<div class="message-top">
 		<b>From:</b> <a href="./profile.php?user={$table.user_id}">{$table.username}</a> | 
		<b>Posted:</b> {$table.posted|date_format:$dateformat} | 
		{if isset($filter)}
			<a href="./showmessages.php?board={$board_id}&amp;topic={$topic_id}">Unfilter</a>
		{else}
			<a href="./showmessages.php?board={$board_id}&amp;topic={$topic_id}&amp;u={$table.user_id}">Filter</a>
		{/if}
		| <a href="./message.php?id={$table.message_id}&amp;topic={$topic_id}&amp;r={$table.revision_id}">Message Detail
		{if $table.revision_id > 1} 
			({$table.revision_id} edits)
		{elseif $table.revision_id == 1} 
			({$table.revision_id} edit)
		{/if}
		</a> |
		<a href="./postmsg.php?board={$board_id}&amp;topic={$topic_id}&amp;quote={$table.message_id}" 
			onclick="return quickpost_quote('t,{$topic_id},{$table.message_id}@{$table.revision_id}');">Quote</a>
	</div>
	<table class="message-body">
		<tr>
			<td msgid="t,{$topic_id},{$table.message_id}@{$table.revision_id}" class="message">
				{$table.message|replace:"<!--\$i-->":$i++}
			</td>
			<td class="userpic">
				<div class="userpic-holder">
					{if $table.avatar != NULL}<img src="./templates/default/images/grey.gif" data-original="{$base_image_url}/t/{$table.avatar}" width="{$table.avatar_width}" height="{$table.avatar_height}" />{/if}
				</div>
			</td>
		</tr>
	</table>
	</div>
{$i = $i+1}
{/foreach}
	<div class="infobar" id="u0_3">Page: 
	{assign var="k" value=1}
	{while $k <= $page_count}
		{if $k == $current_page}{$k} 
			{if $k<$page_count}|{/if}
			{else}
				<a href="./showmessages.php?board=42&amp;topic={$topic_id}&amp;page={$k}">{$k}</a> 
				{if $k < $page_count}| {/if}
		{/if}
		{assign var="k" value=$k+1}
	{/while}
	</div>
	<div class="infobar" id="u0_4">
		There {if $num_readers < 2}is{else}are{/if} currently {$num_readers} {if $num_readers < 2}person{else}people{/if} reading this topic
	</div>
{literal}
	<!--<script type="text/javascript">
		//<![CDATA[
		//onDOMContentLoaded(function(){new TopicManager(7758474, 1, 471, $("u0_1"), [new uiPagerBrowser($("u0_2"), "\/\/boards.endoftheinter.net\/showmessages.php?board=42&topic=7758474", 471, 1), new uiPagerEnum($("u0_3"), "\/\/boards.endoftheinter.net\/showmessages.php?board=42&topic=7758474", 471, 1)], $("u0_4"), ["144115188083614346",471], 0)})
		//]]>
	</script>-->
{/literal}
	<br />
	<br />
	{include file="footer.tpl"}
	<a id="qptoggle" href="#">
		<span id="open">+</span>
		<span id="close" style="display:none">-</span>
	</a>
	<div id="pageexpander" style="height:280px;display:none;"></div>
	<div id="quickpost" style="display:none;">
	<form method="POST" action="./postmsg.php" name="quickposts" id="quickposts">
		<input type="hidden" name="topic" value="{$topic_id}" />
		<input type="hidden" name="token" value="{$token}" />
		<b>Your Message:</b><br />
		<textarea id="qpmessage" name="message">

---
				{$p_signature}
		</textarea>
		<br />
		<input type="submit" value="Post Message" name="submit"/>
	</form>
</div>
</div>
</body>
</html>
