<?php
/*
 * init.php
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

require_once("Config.ini.php");
require_once("User.class.php");
require_once("Smarty.class.php");
require_once("Override.inc.php");
require_once("HTMLPurifier.standalone.php");

$ls = gmdate("D, d M Y H:i:s") . " GMT";
$es =  gmdate("D, d M Y H:i:s", 1)." GMT";

header("Expires: $es");
header("Last-Modified: $ls");
header("Pragma: no-cache");
header("Cache-Control: no-cache, private, no-store, must-revalidate, max-stale=0, post-check=0, pre-check=0");

#Initiate database connection
try{
	// Database Setup 
	$db = new PDO(DATABASE_TYPE.":host=".DATABASE_HOST.";dbname=".DATABASE_NAME,
						DATABASE_USER, DATABASE_PASS);
	$db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
	$db->setAttribute(PDO::ATTR_EMULATE_PREPARES,false);
	$db->setAttribute(PDO::MYSQL_ATTR_USE_BUFFERED_QUERY, true);
	
	// Templating System Setup
	$smarty = new Smarty();
	$smarty->template_dir = TEMPLATE_DIR."/default";
	$smarty->compile_dir = TEMPLATE_COMPILE;
	$smarty->cache_dir = TEMPLATE_CACHE;
	$smarty->config_dir = TEMPLATE_CONFIG;
	$smarty->assign("sitename", SITENAME);
	$smarty->assign("domain", DOMAIN);
	$smarty->assign("dateformat", DATE_FORMAT_SMARTY);
	$smarty->assign("board_id", 42);
	$smarty->assign("base_image_url", BASE_IMAGE_URL);
	
	//HTMLPurifier Setup pre processing
	global $pre_html_purifier;
	$pre_html_purifier_config = HTMLPurifier_Config::createDefault();
	$pre_html_purifier_config->set('Core.EscapeInvalidChildren', 1);
	$pre_html_purifier_config->set('Core.EscapeInvalidTags', 1);
	$pre_html_purifier_config->set('HTML.Allowed', $pre_allowed_elements);
	
	$pre_html_purifier_config->set('HTML.DefinitionID', 'custom_markup');
	$pre_html_purifier_config->set('HTML.DefinitionRev', 1);
	$pre_html_purifier_config->set('Cache.DefinitionImpl', null); //TURN OFF LATER
	if($pre_def = $pre_html_purifier_config->maybeGetRawHTMLDefinition(true)){
		$quote = $pre_def->addElement(
			'quote', // Tag Name
			'Block', // Content Set
			'Flow',  // Allowed Children
			'None', //Attribute Collection
			array(
				'msgid' => 'Text'
				)
			);
		$spoiler = $pre_def->addElement(
			'spoiler', // Tag Name
			'Block', // Content Set
			'Flow',  // Allowed Children
			'None', //Attribute Collection
			array(
				'caption' => 'Text'
				)
			);
	}
	$pre_html_purifier = new HTMLPurifier($pre_html_purifier_config);
	
	//HTMLPurifier Setup post processing
	global $pre_html_purifier;
	$post_html_purifier_config = HTMLPurifier_Config::createDefault();
	$post_html_purifier_config->set('Core.EscapeInvalidChildren', 1);
	$post_html_purifier_config->set('Core.EscapeInvalidTags', 1);
	$post_html_purifier_config->set('HTML.Allowed', $post_allowed_elements);
	
	$post_html_purifier_config->set('HTML.DefinitionID', 'safe_script');
	$post_html_purifier_config->set('HTML.DefinitionRev', 1);
	$post_html_purifier_config->set('Cache.DefinitionImpl', null); //TURN OFF LATER
	if($def = $post_html_purifier_config->maybeGetRawHTMLDefinition(true)){
		$def->addAttribute('div', 'msgid', 'Text');
		$def->addAttribute('span', 'id', 'Text');
		$def->addAttribute('img', 'style', 'Text');
		$def->addAttribute('img', 'data-original', 'Text');
		$safe_script = $def->addElement(
			'safescript',
			'Block',
			'Flow',
			'None',
			array(
				'type' => 'Text'
				)
			);
		$safe_div = $def->addElement(
			'safediv',
			'Inline',
			'Flow',
			'None',
			array(
				'class' => 'Text'
				)
			);
	}

	$post_html_purifier = new HTMLPurifier($post_html_purifier_config);
	
	$sql_sitekey = "SELECT sitekey FROM SiteOptions";
	$statement_sitekey = $db->query($sql_sitekey);
	$results_sitekey = $statement_sitekey->fetch();
	$sitekey = base64_decode($results_sitekey['sitekey']);
	
	define("SITE_KEY", $sitekey);
	
	$authUser = new User($db);
	$auth = $authUser->checkAuthentication(@$_POST['username'], @$_POST['password']);
	if($auth == TRUE){
		$smarty->assign("username", $authUser->getUsername());
		$smarty->assign("user_id", $authUser->getUserID());
		$authUser->awardKarma();
		$smarty->assign("karma", $authUser->getKarma());
		if($authUser->getStatus() == -1){
			$message = "You have been banned";
			$display = "no_access.tpl";
			$page_title = "You have been banned";
			$smarty->assign("message", $message);
			$smarty->assign("reason", override\htmlentities($authUser->getDisciplineReason()));
			require_once("deinit.php");
		}

	}
} catch(PDOException $e){
	print $e->getMessage();
	print "Error :(";
}
?>
