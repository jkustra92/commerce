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
// $Id: tpl_footer.php,v 1.3 2005/09/27 22:33:53 spiderr Exp $
//
  require(DIR_FS_INCLUDES . 'counter.php');

       if ($banner = zen_banner_exists('dynamic', '468x50')) { ?>
<?php   if ($banner->RecordCount() > 0) { ?>
	<div id="banner"><?php echo zen_display_banner('static', $banner); ?></div>
<?php   } ?>
<?php } ?>
