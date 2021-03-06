{strip}
<div class="edit bitcommerce">
	<header class="page-header">
	{if $smarty.const.SHOW_TOTALS_IN_CART}
		<div class="smallText pull-right">
		{$gBitCustomer->mCart->count_contents()} {tr}Items{/tr}
		{if $gBitCustomer->mCart->show_weight()}
			, {$gBitCustomer->mCart->show_weight()|round:2} {tr}lbs{/tr} ( {$gBitCustomer->mCart->show_weight('kg')|round:2} {tr}Kg{/tr} )
		{/if}
		, {$gCommerceCurrencies->format($gBitCustomer->mCart->show_total())}
		</div>
	{/if}
		<h1>{tr}Your Shopping Cart Contains:{/tr}</h1>
	</header>

	<div class="body shopping-cart">
		{form name='cart_quantity' action="`$smarty.const.BITCOMMERCE_PKG_URL`index.php?main_page=shopping_cart"}

{if $gBitCustomer->mCart->count_contents()}

	{if $gBitCustomer->mCart->mErrors.checkout}
		{formfeedback error=$gBitCustomer->mCart->mErrors.checkout}
	{/if}

{foreach from=$gBitCustomer->mCart->contents key=productsKey item=basket}
<div class="row cart-item {cycle values="odd,even"}">
	{assign var=product value=$gBitCustomer->mCart->getProductObject($productsKey)}
	{assign var=productHash value=$gBitCustomer->mCart->getProductHash($productsKey)}
	<div class="col-xs-4 col-sm-2">{if $gCommerceSystem->getConfig('IMAGE_SHOPPING_CART_STATUS')}<a href="{$product->getDisplayUrl()}"><img src="{$product->getThumbnailUrl('avatar')}" class="img-responsive" alt="{$product->getTitle()|escape}"/></a>{/if}</div>
	<div class="col-xs-8 col-sm-6"><a href="{$product->getDisplayUrl()}"><span class="cartproductname">{$product->getTitle()|escape}</span></a>
		{if $basket.attributes}
			<ul class="list-unstyled">
			{foreach from=$basket.attributes key=optionKey item=valueId}
				{assign var=option value=$product->getOptionValue('',$valueId)}
				<li>{$option.products_options_values_name|escape}</li>
			{/foreach}
			</ul>
		{/if}
	</div>
	<div class="col-xs-4 col-sm-2 text-right">
		<input type="number" class="form-control input-mini" name="cart_quantity[{$productsKey}]" value="{$basket.products_quantity}">
	</div>
	<div class="col-xs-4 col-sm-1 currency text-right">{$productHash.final_price_display}{if $productHash.onetime_charges}<br/>{$productHash.onetime_charges_display}{/if}</div>
	<div class="col-xs-4 col-sm-1">
		{forminput label="checkbox"}
			<input type="checkbox" name="cart_delete[]" value="{$productsKey}">
			<a href="{$smarty.const.BITCOMMERCE_PKG_URL}?main_page=shopping_cart&remove_product={$productsKey}">{booticon iname="icon-trash icon-large"  package="icons"  iexplain="Remove from cart"}</a>
		{/forminput}
	</div>
</div>
{/foreach}

	{if $gCommerceSystem->getConfig('SHOW_SHOPPING_CART_UPDATE')}
<div class="row subtotal">
	<div class="col-sm-6 text-right">
	</div>
	<div class="col-sm-6 currency">
		{tr}Sub-Total:{/tr} {$gCommerceCurrencies->format($gBitCustomer->mCart->show_total())}
		<select class="form-control inline-block width-auto ml-1" name="currency" onchange="this.form.submit()">
			{foreach from=$gCommerceCurrencies->currencies item=currencyHash key=currencyCode}
				<option value="{$currencyCode}" {if $smarty.session.currency==$currencyCode || (!$smarty.session.currency && $currencyCode==$smarty.const.DEFAULT_CURRENCY)}selected="selected"{/if}>{$currencyHash.code|escape:html}</option>
			{/foreach}
		</select>
	</div>
	{/if}
	<div class="col-xs-12 text-right">
		<input type="submit" class="btn btn-default" name="update_cart" value="{tr}Update Cart{/tr}" /> <a href="{$smarty.const.BITCOMMERCE_PKG_SSL_URI}?main_page=checkout_proof" class="btn btn-primary">{tr}Checkout{/tr}</a>
	</div>

{else}
	<div>
		{tr}Your Shopping Cart is empty.{/tr}
	</div>
{/if}

	{/form}
	</div><!-- end .body -->
</div>
{/strip}
