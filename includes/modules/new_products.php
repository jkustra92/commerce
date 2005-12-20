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
// $Id: new_products.php,v 1.16 2005/12/20 17:13:01 gilesw Exp $
//
  $title = sprintf(TABLE_HEADING_NEW_PRODUCTS, strftime('%B'));

	$listHash = array();
	$listHash['freshness'] = SHOW_NEW_PRODUCTS_LIMIT;
  	$listHash['max_records'] = MAX_DISPLAY_PRODUCTS_NEW;
	$listHash['offset'] = MAX_DISPLAY_PRODUCTS_NEW * (!empty( $_REQUEST['page'] ) ? ($_REQUEST['page'] - 1) : 0);
	$listHash['sort_mode'] = 'products_date_added_desc';
	if ( !empty( $new_products_category_id ) ) {
		$listHash['category_id'] = $new_products_category_id;
	}

  $new_products = $gBitProduct->getList( $listHash );
  $row = 0;
  $col = 0;
  $list_box_contents = '';

  $num_products_count = count( $new_products );

// show only when 1 or more
  if ($num_products_count > 0) {
    if ($num_products_count < SHOW_PRODUCT_INFO_COLUMNS_NEW_PRODUCTS) {
      $col_width = 100/$num_products_count;
    } else {
      $col_width = 100/SHOW_PRODUCT_INFO_COLUMNS_NEW_PRODUCTS;
    }
// $gBitProduct->debug();
    foreach( $new_products as $product ) {
      $products_price = CommerceProduct::getDisplayPrice($product['products_id']);

      $list_box_contents[$row][$col] = array('align' => 'center',
                                             'params' => 'class="smallText" width="' . $col_width . '%" valign="top"',
                                             'text' => '<a href="' . zen_href_link(zen_get_info_page($product['products_id']), 'products_id=' . $product['products_id']) . '">' . zen_image( CommerceProduct::getImageUrl( $product['products_id'], 'avatar' ), $product['products_name'] ) . '</a><br /><a href="' . zen_href_link( $product['info_page'], 'products_id=' . $product['products_id']) . '">' . $product['products_name'] . '</a><br />' . $products_price);

      $col ++;
      if ($col > (SHOW_PRODUCT_INFO_COLUMNS_NEW_PRODUCTS - 1)) {
        $col = 0;
        $row ++;
      }
    }

    if ( $num_products_count ) {
      if (isset($new_products_category_id)) {
        $category_title = zen_get_categories_name((int)$new_products_category_id);
        $title = sprintf(TABLE_HEADING_NEW_PRODUCTS, strftime('%B')) . ($category_title != '' ? ' - ' . $category_title : '' );
      } else {
        $title = sprintf(TABLE_HEADING_NEW_PRODUCTS, strftime('%B'));
      }
      require( DIR_FS_MODULES . 'tpl_modules_whats_new.php' );
    }
// $gBitProduct->debug( 0 );
  }
?>
