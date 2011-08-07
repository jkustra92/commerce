{literal}
<script type="text/javascript">/* <![CDATA[ */
function editAddress( pAddress ) {
	jQuery.ajax({
		data: 'address_type='+pAddress+'&oID='+{/literal}{$smarty.request.oID}{literal},
		url: "{/literal}{$smarty.const.BITCOMMERCE_PKG_URL}admin/orders.php{literal}",
		timeout: 60000,
		success: function(r) { 
			$('#'+pAddress+'address').html(r);
		}
	})
}
/* ]]> */</script>
{/literal}


<table>
<tr>
	<td valign="top">
		{$order->info.date_purchased|bit_long_datetime}<br/>
		{displayname hash=$order->customer} (ID: {$order->customer.user_id})
		<a href="product_history.php?user_id={$order->customer.user_id}">{biticon iname="appointment-new" iexplain="Customer Sales History"}</a>
		{smartlink ipackage=users ifile="admin/index.php" assume_user=$order->customer.user_id ititle="Assume User Identity" ibiticon="users/assume_user" iforce=icon} 
		<br/>
{if $order->customer.telephone}
	{$order->customer.telephone}<br/>
{/if}
		<a href="mailto:{$order->customer.email_address}">{$order->customer.email_address}</a><br/>
		{if $order->customer.referer_url}{$order->customer.referer_url|stats_referer_display_short}<br/>{/if}
		{if $customerStats.orders_count == 1}<em>First Order</em>
		{else}
		<strong>Tier {$customerStats.tier|round}</strong>: <a href="list_orders.php?user_id={$order->customer.user_id}&amp;orders_status_id=all&amp;list_filter=all">{$customerStats.orders_count} {tr}orders{/tr} {tr}total{/tr} ${$customerStats.customers_total|round:2} {tr}over{/tr} {$customerStats.customers_age}</a> 
			{if $customerStats.gifts_redeemed || $customerStats.gifts_balance}<br/>
				Gift: ${$customerStats.gifts_redeemed} redeemed {if $customerStats.gifts_balance|round:2}, ${$customerStats.gifts_balance|round:2} {tr}remaining{/tr}{/if}{if $customerStats.commissions}, ${$customerStats.commissions|round:2} {tr}Commissions{/tr}{/if}
			{/if}
		{/if}
	</td>
	<td>
		{if $order->info.cc_type || $order->info.cc_owner || $order->info.cc_number}
		<table style="width:auto;">
			  <tr>
				<td colspan="2"><strong>Credit Card Info</strong></td>
			  </tr>
			  <tr>
				<td class="main">Type:</td>
				<td class="main">{$order->info.cc_type}: {$order->info.cc_owner}</td>
			  </tr>
			  <tr>
				<td class="main">Number:</td>
				<td class="main">{$order->info.cc_number}</td>
			  </tr>
			  <tr>
				<td class="main">Expires:</td>
				<td class="main">{$order->info.cc_expires} CVV: {$order->getField('cc_cvv')}</td>
			  </tr>
			  <tr>
				<td class="main">Trans ID:</td>
				<td class="main">{$order->info.cc_ref_id}</td>
			  </tr>
		</table>
		{/if}
		IP: {$order->info.ip_address}
	</td>
	</tr>
	<tr>
		<td valign="top">
			<strong>{tr}Shipping Address{/tr}</strong> [<a onclick="editAddress('delivery');return false;">Edit</a>]<br/>
<div id="deliveryaddress">
{php}
global $order;
echo zen_address_format($order->delivery['format_id'], $order->delivery, 1, '', '<br />');
{/php}
</div>
		</td>
		<td valign="top">
			<strong>{tr}Billing Address{/tr}</strong> [<a onclick="editAddress('billing');return false;">Edit</a>]<br/>
<div id="billingaddress">
{php}
global $order;
echo zen_address_format($order->billing['format_id'], $order->billing, 1, '', '<br />');
{/php}
</div>
		</td>
	  </tr>
	</table>

		</td>
	</tr>
	{if $notificationBlock}
	<tr>
		<td>
			{$notificationBlock}
		</td>
	</tr>
	{/if}
</table>

