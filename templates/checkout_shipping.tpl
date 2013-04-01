{strip}

<div class="floaticon">{bithelp}</div>
<div class="edit bitcommerce">
	{if !$gBitUser->isRegistered() || !$order->delivery || $changeAddress}
		<div class="page-header">
		</div>

		<div class="body">
			{form name='checkout_address' action="`$smarty.const.BITCOMMERCE_PKG_URL`index.php?main_page=checkout_shipping"}
				<input type="hidden" name="main_page" value="checkout_shipping" />
				{if !$gBitUser->isRegistered()}
					{include file="bitpackage:bitcommerce/register_customer.tpl"}
				{/if}

				{if count( $addresses )}
				<div class="width50p floatleft">
					<h1>{tr}Choose From Your Address Book or...{/tr}</h1>
					{tr}Please select the preferred shipping address if this order is to be delivered elsewhere.{/tr}
					{include file="bitpackage:bitcommerce/address_list.tpl"}
				</div>
				{/if}
				
				<div class="width50p floatleft">
					{legend legend="Enter a New Shipping Address"}
						{include_php file="`$smarty.const.BITCOMMERCE_PKG_PATH`pages/address_new/address_new.php"}
					{/legend}
				</div>

				<div class="control-group clear">
					{forminput}
						<input type="submit" name="" value="Cancel" />
						<input type="submit" name="submit_address" value="Continue" />
					{/forminput}
				</div>
			{/form}
		</div><!-- end .body -->
	{else}
		<div class="page-header">
			<h1>{tr}Step 1 of 3 - Delivery Information{/tr}</h1>
		</div>

		<div class="body">
			{form name='checkout_address' }
				<input type="hidden" name="action" value="process" />
				<input type="hidden" name="main_page" value="checkout_shipping" />
				<div class="control-group">
					{formlabel label="Shipping Address"}
					{forminput}
						{assign var=address value=$order->delivery}
<fieldset>
						{include file="bitpackage:bitcommerce/address_display.tpl"}
</fieldset>
						{formhelp note="Your order will be shipped to the following address or you may change the shipping address by clicking the Change Address button."}
					{/forminput}
				</div>

				<div class="control-group submit">
					<input type="submit" name="change_address" value="{tr}Change address{/tr}" />
				</div>

				<div class="clear"></div>

				{if $shippingModules}
					<h3>{tr}Shipping Method{/tr}</h3>
					{if count( $quotes ) > 1}
						<p>{tr}Please select the preferred shipping method to use on this order.{/tr}</p>
					{elseif !$freeShipping}
						<p>{tr}This is currently the only shipping method available to use on this order.{/tr}</p>
					{/if}
<fieldset>
					{if $freeShipping}
						<table border="1" width="100%" cellspacing="2" cellpadding="2">
							<tr>
								<td colspan="3" width="100%">
									<table border="0" width="100%" cellspacing="0" cellpadding="2">
										<tr>
											<td colspan="3">{tr}Free Shipping{/tr}&nbsp;{$quotes.$i.icon}</td>
										</tr>
										<tr id="defaultSelected" class="moduleRowSelected" onmouseover="rowOverEffect(this)" onmouseout="rowOutEffect(this)" onclick="selectRowEffect(this, 0)">
											<td width="100%">sprintf(FREE_SHIPPING_DESCRIPTION, $currencies->format(MODULE_ORDER_TOTAL_SHIPPING_FREE_SHIPPING_OVER)) . zen_draw_hidden_field('shipping', 'free_free')</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					{else}
						{include file="bitpackage:bitcommerce/checkout_javascript.tpl"}
						{include file="bitpackage:bitcommerce/shipping_quotes_inc.tpl"}
					{/if}
				{/if}
</fieldset>

<fieldset>
				<div class="control-group">
					{formlabel label="Special Instructions or Comments About Your Order" for=""}
					{forminput}
						<textarea name="comments" wrap="soft" cols="60" rows="5">{$smarty.session.comments}</textarea>
					{/forminput}
				</div>
</fieldset>

				<div class="clear"></div>

				<h3>{tr}Continue to Step 2{/tr}</h3>
				<p>{tr}- choose your payment method.{/tr} </p>
				<div class="control-group submit">
					<input type="submit" value="Continue" />
				</div>
			{/form}
		</div><!-- end .body -->
	{/if}
</div>
{/strip}
