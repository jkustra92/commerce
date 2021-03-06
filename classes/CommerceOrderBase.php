<?php
// +----------------------------------------------------------------------+
// | bitcommerce															|
// | Copyright (c) 2007-2009 bitcommerce.org									 |
// | http://www.bitcommerce.org											 |
// | This source file is subject to version 2.0 of the GPL license		|
// +----------------------------------------------------------------------+
/**
 * @version	$Header$
 *
 * Base class for handling common functionality between shipping cart and orders
 *
 * @package	bitcommerce
 * @author	 spider <spider@steelsun.com>
 */


class CommerceOrderBase extends BitBase {

	public $mProductObjects = array();
	public $total;
	public $weight;
	public $free_shipping_item;
	public $free_shipping_weight;
	public $free_shipping_price;
	public $contents;

	// can take a productsKey or a straight productsId
	function getProductObject( $pProductsMixed ) {
		$productsId = zen_get_prid( $pProductsMixed );
		if( BitBase::verifyId( $productsId ) ) {
			if( !isset( $this->mProductObjects[$productsId] ) ) {
				if( $this->mProductObjects[$productsId] = bc_get_commerce_product( $productsId ) ) {
					$ret = &$this->mProductObjects[$productsId];
				}
			}
		}
		return $this->mProductObjects[$productsId];
	}

	function getWeight() {
		if( empty( $this->weight ) ) {
			$this->calculate();
		}
		return( $this->weight );
	}

}
