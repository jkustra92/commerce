<div class="admin bitcommerce">
	<div class="page-header">
		<h1>{tr}Edit Customer:{/tr}</h1>
	</div>
	<div class="body">

	{form class="form-horizontal" name="customer" method="post" action="`$smarty.server.SCRIPT_NAME`"}
		<input type="hidden" name="action" value="update">
		<input type="hidden" name="default_address_id" value="{$cInfo->customers_default_address_id}">
		{legend legend=$smarty.const.CATEGORY_PERSONAL}
		{if $gCommerceSystem->isConfigActive('ACCOUNT_GENDER')}
			<div class="control-group">
				{formlabel label='Gender'}
				{forminput}
					<label class="radio inline">
					<input type="radio" name="customers_gender" value="f" {if $cInfo->customers_gender=='f'}selected="selected"{/if}/> {tr}Female{/tr}
					</label>
					<label class="radio inline">
					<input type="radio" name="customers_gender" value="m" {if $cInfo->customers_gender=='m'}selected="selected"{/if}/> {tr}Male{/tr}
					</label>
				{/forminput}
			</div>
		{/if}
			<div class="control-group">
				{formlabel label='Authorization Status'}
				{forminput}
					{html_options name='customers_authorization' options=$customerAuth selected=$cInfo->customers_authorization}
				{/forminput}
			</div>
			<div class="control-group">
				{formlabel label='Email'}
				{forminput}
					<input type="text" name="customers_email_address" value="{$cInfo->customers_email_address|escape}"/>
				{/forminput}
			</div>
			<div class="control-group">
				{formlabel label='First Name'}
				{forminput}
					<input type="text" name="customers_firstname" value="{$cInfo->customers_firstname|escape}"/>
				{/forminput}
			</div>
			<div class="control-group">
				{formlabel label='Last Name'}
				{forminput}
					<input type="text" name="customers_lastname" value="{$cInfo->customers_lastname|escape}"/>
				{/forminput}
			</div>
		{if $gCommerceSystem->isConfigActive('ACCOUNT_DOB')}
			<div class="control-group">
				{formlabel label='Date of Birth'}
				{forminput}
					<input type="text" class="input-small" name="customers_dob" value="{$cInfo->customers_dob|zen_date_short}"/>
				{/forminput}
			</div>
		{/if}

			<div class="control-group">
				{formlabel label='Discount Pricing Group'}
				{forminput}
					{html_options name="customers_group_pricing" options=$groupPricing selected=$cInfo->customers_group_pricing}
				{/forminput}
			</div>
		{/legend}

		<div class="control-group submit">
			<input type="submit" class="btn btn-primary" name="Save" value="Save"/>
			<a href="{$smarty.server.HTTP_REFERER}" class="btn">{tr}Cancel{/tr}</a>
		</div>
		{/form}
	</div>
</div>