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
// $Id$
//

define('NAVBAR_TITLE_1', tra( 'My Account' ) );
define('NAVBAR_TITLE_2', tra( 'Address Book' ) );

define('NAVBAR_TITLE_ADD_ENTRY', tra( 'New Entry' ) );
define('NAVBAR_TITLE_MODIFY_ENTRY', tra( 'Update Entry' ) );
define('NAVBAR_TITLE_DELETE_ENTRY', tra( 'Delete Entry' ) );

define('DELETE_ADDRESS_TITLE', tra( 'Delete Address' ) );
define('DELETE_ADDRESS_DESCRIPTION', tra( 'Are you sure you would like to delete the selected address from your address book?' ) );

define('SELECTED_ADDRESS', tra( 'Selected Address' ) );

define('SUCCESS_ADDRESS_BOOK_ENTRY_DELETED', tra( 'The selected address has been successfully removed from your address book.' ) );
define('SUCCESS_ADDRESS_BOOK_ENTRY_UPDATED', tra( 'Your address book has been successfully updated.' ) );

define('WARNING_PRIMARY_ADDRESS_DELETION', tra( 'The primary address cannot be deleted. Please set another address as the primary address and try again.' ) );

define('ERROR_NONEXISTING_ADDRESS_BOOK_ENTRY', tra( 'The address book entry does not exist.' ) );
define('ERROR_ADDRESS_BOOK_FULL', tra( 'Your address book is full. Please delete an unneeded address to save a new one.' ) );
?>
