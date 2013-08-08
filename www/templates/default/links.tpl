{include file="header.tpl"}
	<h1>Links</h1>
	<h2>View Links by Category</h2>
	<p class="categoryList">
		<a href="./links.php?mode=all">All Links</a> | 
		<a href="./links.php?mode=category&id=1">Android</a> | 
		<a href="./links.php?mode=category&id=2">iOS</a> | 
		<a href="./links.php?mode=category&id=3">API</a> | 
		<a href="./links.php?mode=category&id=19">Yii</a> |
		<a href="./links.php?mode=category&id=15">Hardware</a> | 
		<a href="./links.php?mode=category&id=16">PHP</a> | 
		<a href="./links.php?mode=category&id=17">MySQL</a> | 
		<a href="./links.php?mode=category&id=18">Git</a> |
		<a href="./links.php?mode=category&id=11">Testing</a> | 
		<a href="./links.php?mode=category&id=7">UI/UX</a> | 
		<a href="./links.php?mode=category&id=8">Libraries</a> | 
		<a href="./links.php?mode=category&id=9">Resources</a> | 
		<a href="./links.php?mode=category&id=10">Tutorial</a> | 
		
		<a href="./links.php?mode=category&id=4">Technology</a> | 
		<a href="./links.php?mode=category&id=5">Funny</a> | 
		<a href="./links.php?mode=category&id=6">Off-Topic</a> | 
		<a href="./links.php?mode=category&id=12">Music</a> | 
		<a href="./links.php?mode=category&id=13">Gaming</a> | 
		<a href="./links.php?mode=category&id=14">Other</a>
	</p>
	<div class="userbar">
		<a href="./profile.php?user={$user_id}">{$username}</a> :
		<span id="userbar_pms" style="display:none">
			<a href="./inbox.php">Private Messages (<span id="userbar_pms_count">0</span>)</a>
		|</span> 
		<!-- <a href="./links.php?mode=user&amp;userid=18026&amp;type=3#"onclick="return toggle_spoiler(document.getElementById('links_cat_filt'))">Edit category filters</a> | 
		<a href="https://wiki.endoftheinter.net/index.php/Help:Rules">Help</a>
		-->
	</div>


	<div class="infobar">
		Page 1 of <span>1</span> <span style="display:none">| 
		<a href="https://links.endoftheinter.net/links.php?mode=user&amp;userid=18026&amp;type=3&amp;page=2">Next Page</a></span>
		<span style="display:none">
			| <a href="https://links.endoftheinter.net/links.php?mode=user&amp;userid=18026&amp;type=3&amp;page=1">Last Page</a>
		</span>
	</div>

	<table class="grid">
		<tbody>
			<tr>
				<th>
					<a href="./links.php?mode=user&amp;userid=&amp;type=3&amp;category=0&amp;exclude=0&amp;sort=2&amp;sortd=1">Title</a>
				</th>
				<th>
					<a href="./links.php?mode=user&amp;userid=18026&amp;type=3&amp;category=0&amp;exclude=0&amp;sort=1&amp;sortd=1">Added By:</a>
				</th>
				<th>
					<a href="./links.php?mode=user&amp;userid=18026&amp;type=3&amp;category=0&amp;exclude=0&amp;sort=1&amp;sortd=1">Date</a>
				</th>
				<th>
					<a href="./links.php?mode=user&amp;userid=18026&amp;type=3&amp;category=0&amp;exclude=0&amp;sort=4&amp;sortd=2">Rating</a>
				</th>
				<th>
					<a href="./links.php?mode=user&amp;userid=18026&amp;type=3&amp;category=0&amp;exclude=0&amp;sort=6&amp;sortd=2">Rank</a>
				</th>
        		</tr>
{foreach from=$links key=header item=table}
			<tr class="r0">
				<td>
					<a href="./linkme.php?l={$table.link_id}">{$table.title}</a>
				</td>	
				<td>
					<a href="./profile.php?user={$table.user_id}">{$table.username}</a>
				</td>
			  	<td>
					{$table.created|date_format:$dateformat}
				</td>
				<td>
					{$table.rating|string_format:"%.2f"}/10 (based on {$table.NumberOfVotes} votes)
				</td>
				<td>
					{$table.rank|string_format:"%.0f"}
				</td>
			</tr>
{/foreach}
		</tbody>
	</table>
	<div class="infobar">
		Page: 1
	</div>
	<br />
	<br />
	{include file="footer.tpl"}
</div>
</body>
</html>
