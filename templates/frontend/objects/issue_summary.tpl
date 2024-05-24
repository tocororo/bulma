{**
 * templates/frontend/objects/issue_summary.tpl
 *
 * Copyright (c) 2014-2021 Simon Fraser University
 * Copyright (c) 2003-2021 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief View of an Issue which displays a summary for use in lists
 *
 * @uses $issue Issue The issue
 *}
{if $issue->getShowTitle()}
	{assign var=issueTitle value=$issue->getLocalizedTitle()}
{/if}
{assign var=issueSeries value=$issue->getIssueSeries()}
{assign var=issueCover value=$issue->getLocalizedCoverImageUrl()}


<div class="issue_archive card">
	{if $issueCover}
		<div class="card-image">

			<img class="image is-fullwidth is-cover" src="{$issueCover|escape}"
				alt="{$issue->getLocalizedCoverImageAltText()|escape|default:''}">

		</div>
	{/if}
	<div class="card-content">
		<a href="{url op="view" path=$issue->getBestIssueId()}">

			<p class="title is-5">
				{* <a class="title" href="{url op="view" path=$issue->getBestIssueId()}"> *}
				{if $issueSeries}
					{$issueSeries|escape}
				{else}
					{$issueTitle|escape}
				{/if}
				{* </a> *}
			</p>

			{if $issueTitle && $issueSeries}
				<p class="series subtitle is-6">
					{$issueTitle|escape}
				</p>
			{/if}
			<div class="description content">
				{$issue->getLocalizedDescription()|strip_unsafe_html}
			</div>
		</a>
	</div>
	<footer class="card-footer">
	</footer>
</div>

{* 

<div class="obj_issue_summary">

	{if $issueCover}
		<a class="cover" href="{url op="view" path=$issue->getBestIssueId()}">
			<img src="{$issueCover|escape}" alt="{$issue->getLocalizedCoverImageAltText()|escape|default:''}">
		</a>
	{/if}

	<h2>
		<a class="title" href="{url op="view" path=$issue->getBestIssueId()}">
			{if $issueTitle}
				{$issueTitle|escape}
			{else}
				{$issueSeries|escape}
			{/if}
		</a>
		{if $issueTitle && $issueSeries}
			<div class="series">
				{$issueSeries|escape}
			</div>
		{/if}
	</h2>

	<div class="description">
		{$issue->getLocalizedDescription()|strip_unsafe_html}
	</div>
</div><!-- .obj_issue_summary --> *}