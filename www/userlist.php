<?php
/*
 * userlist.php
 * 
 * Copyright (c) 2012 Andrew Jordan
 * 
 * Permission is hereby granted, free of charge, to any person obtaining 
 * a copy of this software and associated documentation files (the 
 * "Software"), to deal in the Software without restriction, including 
 * without limitation the rights to use, copy, modify, merge, publish, 
 * distribute, sublicense, and/or sell copies of the Software, and to 
 * permit persons to whom the Software is furnished to do so, subject to 
 * the following conditions:
 *
 * The above copyright notice and this permission notice shall be 
 * included in all copies or substantial portions of the Software. 
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. 
 * IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY 
 * CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, 
 * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE 
 * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */
 
require("includes/init.php");
if($auth == TRUE){
	if(!is_numeric(@$_GET['page']) || @$_GET['page'] == NULL)
		$current_page = 1;
	else
		$current_page = intval($_GET['page']);
	$query = @$_GET['user'];
	$userlist = User::getUserList($db, $current_page,$query);
	$smarty->assign("userlist", $userlist);
	$smarty->assign("page_count", User::$page_count);
	$smarty->assign("current_page", $current_page);	
	$display = "userlist.tpl";
	$page_title = "User List";
	$smarty->assign("user_search", override\htmlentities($query));
	require("includes/deinit.php");

}else
	require("404.php");
?>

