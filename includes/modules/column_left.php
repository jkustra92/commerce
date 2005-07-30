<?php
//
// +----------------------------------------------------------------------+
// |zen-cart Open Source E-commerce                                       |
// +----------------------------------------------------------------------+
// | Copyright (c) 2003 The zen-cart developers                           |
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
// $Id: column_left.php,v 1.3 2005/07/30 15:59:38 spiderr Exp $
//
	global $moduleTitle;
	$column_box_default='tpl_box_default_left.php';
	// Check if there are boxes for the column
	$column_left_display= $db->Execute("select layout_box_name from " . TABLE_LAYOUT_BOXES . " where layout_box_location = 0 and layout_box_status= '1' and layout_template ='" . $template_dir . "'" . ' order by layout_box_sort_order');
	// safety row stop
	$box_cnt=0;
	while (!$column_left_display->EOF and $box_cnt < 100) {
		$box_cnt++;
		$column_box_spacer = 'column_box_spacer_left';
		$column_width = BOX_WIDTH_LEFT;
		$box_id = zen_get_box_id($column_left_display->fields['layout_box_name']);
		$moduleTitle = '';
		$gBitSmarty->assign( 'moduleTitle', $moduleTitle );
		print $gBitSmarty->fetch( "bitpackage:bitcommerce/mod_".str_replace( '.php', '.tpl', $column_left_display->fields['layout_box_name'] ) );
		$column_left_display->MoveNext();
	} // while column_left
?>