{foreach from=$customersInterests key=interestsId item=interest}
<label class="checkbox">
	<input type="checkbox" name="interersts_id" onchange="storeCustomerInterest(this.value,this.checked)" value="{$interestsId}" {if $interest.is_interested}checked="checked"{/if}/>{$interest.interests_name}</li>
</label>
{/foreach}
<div id="interestsfeedback"></div>
{literal}
<script type="text/javascript">/* <![CDATA[ */
function storeCustomerInterest( pInterestsId, pChecked ) {
	var action = pChecked ? 'savec2i' : 'deletec2i';
	jQuery.ajax({
		data: 'action='+action+'&interests_id='+pInterestsId+'&customers_id='+{/literal}{$order->customer.user_id}{literal},
		url: "{/literal}{$smarty.const.BITCOMMERCE_PKG_URL}admin/interests.php{literal}",
		timeout: 60000,
		success: function(r) { 
			$('#interestsfeedback').html(r);
		}
	})
}
/* ]]> */</script>
{/literal}
