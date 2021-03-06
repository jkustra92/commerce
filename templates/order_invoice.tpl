
<header>
	<div class="row">
		<div class="col-xs-12 col-sm-6 text-center">
			<h1 class="page-heading">{tr}Order{/tr} #{$order->mOrdersId}</h1>
			<div class="date">{tr}Purchased{/tr}: {$order->getField('date_purchased')|bit_long_datetime}</div>
		</div>
		<div class="col-xs-12 col-sm-6">
			<div class="panel panel-default height">
				<div class="panel-body">
					<h2>{$gBitSystem->getConfig('site_title')}</h2>
					{$smarty.const.STORE_NAME_ADDRESS|nl2br}
				</div>
			</div>
		</div>
	</div>
</header>

<div class="row clear">
	<div class="col-sm-4 col-xs-6">
		<div class="panel panel-default height">
			<div class="panel-heading">{tr}Billing Address{/tr}</div>
			<div class="panel-body">
				{$order->getFormattedAddress('billing')}
			</div>
		</div>
	</div>
	{if $order->delivery}
	<div class="col-sm-4 col-xs-6">
		<div class="panel panel-default height">
			<div class="panel-heading">{tr}Delivery Address{/tr}</div>
			<div class="panel-body">
				{$order->getFormattedAddress('delivery')}
			</div>
		</div>
	</div>
	{/if}

	<div class="col-sm-4 col-xs-12">
		<div class="row">
			<div class="col-sm-12 col-xs-6">
				<div class="panel panel-default height">
					<div class="panel-heading">{tr}Payment{/tr}</div>
					<div class="panel-body">
						{if $order->info.cc_type || $order->info.cc_owner || $order->info.cc_number}
						<div class="clear">
							<div class="pull-left">{$order->info.cc_type}: </div>
							<div class="pull-right">{$order->info.cc_owner}</div>
						</div>
						<div class="clear">
							<div class="pull-left">{tr}Number{/tr}: </div>
							<div class="pull-right">{$order->info.cc_number}</div>
						</div>
						<div class="clear">
							<div class="pull-left">{tr}Expires{/tr}: </div>
							<div class="pull-right">{$order->info.cc_expires} CVV: {$order->getField('cc_cvv')}</div>
						</div>
						<div class="clear">
							<div class="pull-left">{tr}Transaction ID{/tr}: </div>
							<div class="pull-right">{$order->info.cc_ref_id}</div>
						</div>
						{/if}
						<div class="clear">
							<div class="pull-left">{tr}IP{/tr}:</div>
							<div class="pull-right"> {$order->info.ip_address}</div>
						</div>
					</div>
				</div>
			</div>
			{if $order->getField('shipping_method')}
			<div class="col-sm-12 col-xs-6">
				<div class="panel panel-default height">
					<div class="panel-heading">{tr}Shipping{/tr}</div>
					<div class="panel-body">
						{$order->getField('shipping_method')} {$order->getField('shipping_method_code')}
					</div>
				</div>
			</div>
			{/if}
		</div>
	</div>
</div>

{include file="bitpackage:bitcommerce/order_invoice_contents_inc.tpl"}

{if $order->mHistory}
<h3>{tr}Status History & Comments{/tr}</h3>
<ul class="list-unstyled">
{foreach from=$order->mHistory|@array_reverse item=history}
	{if $history.customer_notified || $gBitUser->hasPermission( 'p_bitcommerce_admin' )}
	<li class="alert {if $history.customer_notified}alert-warning{else}alert-info{/if}">
		<div class="strong"><strong>{$history.date_added|bit_short_datetime}</strong> <em>{$history.orders_status_name}</em></div>
		{if $history.comments|escape:"html"}
		<p>{$history.comments}</p>
		{/if}
   </li>
   {/if}
{/foreach}
</ul>
{/if}

<a class="btn btn-default" href="mailto:{$smarty.const.STORE_OWNER_EMAIL_ADDRESS}">Contact Us</a>
