<?php
//
// +----------------------------------------------------------------------+
// |zen-cart Open Source E-commerce                                       |
// +----------------------------------------------------------------------+
// | Copyright (c) 2004 The zen-cart developers                           |
// |                                                                      |
// | http://www.zen-cart.com/index.php                                    |
// |                                                                      |
// | Portions Copyright (c) 2003 osCommerce                               |
// +----------------------------------------------------------------------+
// | This source file is subject to version 2.0 of the GPL license,       |
// | that is bundled with this package in the file LICENSE, and is        |
// | available through the world-wide-web at the following url:           |
// | http://www.zen-cart.com/license/2_0.txt.                             |
// | If you did not receive a copy of the zen-cart license and are unable |
// | to obtain it through the world-wide-web, please send a note to       |
// | license@zen-cart.com so we can mail you a copy immediately.          |
// +----------------------------------------------------------------------+
// $Id: index.php,v 1.16 2005/10/06 21:01:41 spiderr Exp $
//

	// These classes need to be included first so they get written to the session properly
	require_once('includes/classes/shopping_cart.php');
	require_once('includes/classes/navigation_history.php');
	require_once('../bit_setup_inc.php');

	require_once('includes/application_top.php');

	global $gCommercePopupTemplate;


// We need to buffer output
ob_start();

	// determine the page directory


	if( empty( $_REQUEST['main_page'] ) ) {
		if( $infoPage = $gBitProduct->getInfoPage() ) {
			$_REQUEST['main_page'] = $infoPage;
		} else {
			$_REQUEST['main_page'] = 'index';
		}
		// compatibility for shite code
		$_GET['main_page'] = $_REQUEST['main_page'];
	}

	if (MISSING_PAGE_CHECK == 'true') {
	//	if (!is_dir(DIR_WS_MODULES .  'pages/' . $_REQUEST['main_page'])) $_REQUEST['main_page'] = 'index';
	}

	$current_page = $_REQUEST['main_page'];
	$current_page_base = $current_page;
	$code_page_directory = DIR_FS_PAGES . $current_page_base;
	$page_directory = $code_page_directory;

	$language_page_directory = DIR_WS_LANGUAGES . $gBitCustomer->getLanguage() . '/';

	// load all files in the page directory starting with 'header_php'

	$directory_array = $template->get_template_part($code_page_directory, '/^header_php/');
	while(list ($key, $value) = each($directory_array)) {
		require($code_page_directory . '/' . $value);
	}

	require($template->get_template_dir('html_header.php',DIR_WS_TEMPLATE, $current_page_base,'common'). '/html_header.php');

	// Define Template Variables picked up from includes/main_template_vars.php unless a file exists in the
	// includes/pages/{page_name}/directory to overide. Allowing different pages to have different overall
	//templates.

	require($template->get_template_dir('main_template_vars.php',DIR_WS_TEMPLATE, $current_page_base,'common'). '/main_template_vars.php');

	// Read the "on_load" scripts for the individual page, and from the site-wide template settings
	// NOTE: on_load_*.js files must contain just the raw code to be inserted in the <body> tag in the on_load="" parameter.
	// Looking in "/includes/modules/pages" for files named "on_load_*.js"
	$directory_array = $template->get_template_part(DIR_FS_PAGES . $current_page_base, '/^on_load_/', '.js');
	while(list ($key, $value) = each($directory_array)) {
		$onload_file = DIR_FS_PAGES . $current_page_base . '/' . $value;
		$read_contents='';
		$lines = @file($onload_file);
		foreach($lines as $line) {
			$read_contents.=$line;
		}
		$za_onload_array[]=$read_contents;
	}
	//now read "includes/templates/TEMPLATE/jscript/on_load/on_load_*.js", which would be site-wide settings
	$directory_array=array();
	$tpl_dir=$template->get_template_dir('.js', DIR_WS_TEMPLATE, 'jscript/on_load', 'jscript/on_load_');
	$directory_array = $template->get_template_part($tpl_dir ,'/^on_load_/', '.js');
	while(list ($key, $value) = each($directory_array)) {
		$onload_file = $tpl_dir . '/' . $value;
		$read_contents='';
		$lines = @file($onload_file);
		foreach($lines as $line) {
			$read_contents.=$line;
		}
		$za_onload_array[]=$read_contents;
	}
	if( !empty( $zc_first_field ) ) $za_onload_array[] = $zc_first_field; // for backwards compatibility with previous $zc_first_field usage
	$zv_onload = '';
	if( !empty( $za_onload_array ) ) $zv_onload=implode(';',$za_onload_array);
	$zv_onload = str_replace(';;',';',$zv_onload.';'); //ensure we have just one ';' between each, and at the end
	if (trim($zv_onload) == ';') $zv_onload='';  // ensure that a blank list is truly blank and thus ignored.

	// Define the template that will govern the overall page layout, can be done on a page by page basis
	// or using a default template. The default template installed will be a standard 3 column lauout. This
	// template also loads the page body code based on the variable $body_code.

	require($template->get_template_dir('tpl_main_page.php',DIR_WS_TEMPLATE, $current_page_base,'common'). '/tpl_main_page.php');
	print '</html>';

	require(DIR_FS_INCLUDES . 'application_bottom.php');

$gBitSmarty->assign_by_ref( 'bitcommerceCenter', ob_get_contents() );
ob_end_clean();

if( !empty( $gCommercePopupTemplate ) ) {
	$gBitSmarty->display( $gCommercePopupTemplate );
} else {
	$gBitSystem->display( 'bitpackage:bitcommerce/view_bitcommerce.tpl' );
}

?>
