{**
 * templates/frontend/objects/issue_toc.tpl
 *
 * Copyright (c) 2014-2021 Simon Fraser University
 * Copyright (c) 2003-2021 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief View of an Issue which displays a full table of contents.
 *
 * @uses $issue Issue The issue
 * @uses $issueTitle string Title of the issue. May be empty
 * @uses $issueSeries string Vol/No/Year string for the issue
 * @uses $issueGalleys array Galleys for the entire issue
 * @uses $hasAccess bool Can this user access galleys for this context?
 * @uses $publishedSubmissions array Lists of articles published in this issue
 *   sorted by section.
 * @uses $primaryGenreIds array List of file genre ids for primary file types
 * @uses $heading string HTML heading element, default: h2
 *}
{if !$heading}
	{assign var="heading" value="h1"}
{/if}
{assign var="sectionHeading" value="h3"}
{assign var="articleHeading" value="h4"}

{if $heading == "h2"}
	{assign var="sectionHeading" value="h4"}
	{assign var="articleHeading" value="h5"}
{elseif $heading == "h3"}
	{assign var="sectionHeading" value="h5"}
	{assign var="articleHeading" value="h6"}
{elseif $heading == "h4"}
	{assign var="sectionHeading" value="h5"}
	{assign var="articleHeading" value="h6"}
{/if}

{assign var=issueTitle value=$issue->getLocalizedTitle()}
{assign var=issueSeries value=$issue->getIssueSeries()}

{if $showTitle}
	<{$heading} >
		{* <a class="title" href="{url op="view" path=$issue->getBestIssueId()}"> *}
		{if $issueSeries}
			{$issueSeries|escape}
		{else}
			{$issueTitle|escape}
		{/if}
		{* </a> *}

</{$heading}>
		{if $issueTitle && $issueSeries}
			<{$articleHeading} class="series subtitle">
				{$issueTitle|escape}
			</{$articleHeading}>
		{/if}
	
{/if}


<div class="obj_issue_toc">
	{* Indicate if this is only a preview *}
	{if !$issue->getPublished()}
		{include file="frontend/components/notification.tpl" type="warning" messageKey="editor.issues.preview"}
	{/if}

	{* Issue introduction area above articles *}
	<div class="columns">
		<div class="column is-3">

		</div>
		<div class="column">
			{* Issue cover image *}
			{assign var=issueCover value=$issue->getLocalizedCoverImageUrl()}
			{if $issueCover}
				<a class="cover" href="{url op="view" page="issue" path=$issue->getBestIssueId()}">
					{capture assign="defaultAltText"}
						{translate key="issue.viewIssueIdentification" identification=$issue->getIssueIdentification()|escape}
					{/capture}
					<img src="{$issueCover|escape}"
						alt="{$issue->getLocalizedCoverImageAltText()|escape|default:$defaultAltText}">
				</a>
			{/if}

			{* Published date *}
			{if $issue->getDatePublished()}
				<div class="published tags has-addons">
					<span class="tag is-dark">
						{translate key="submissions.published"}:
					</span>
					<span class="tag is-link">
						{$issue->getDatePublished()|date_format:$dateFormatShort}
					</span>
				</div>
			{/if}
			{* Description *}
			{if $issue->hasDescription()}
				<div class="description content">
					{$issue->getLocalizedDescription()|strip_unsafe_html}
				</div>
			{/if}

			{* PUb IDs (eg - DOI) *}
			<div class="field is-grouped is-grouped-multiline">
				{foreach from=$pubIdPlugins item=pubIdPlugin}
					{assign var=pubId value=$issue->getStoredPubId($pubIdPlugin->getPubIdType())}
					{if $pubId}
						{assign var="doiUrl" value=$pubIdPlugin->getResolvingURL($currentJournal->getId(), $pubId)|escape}
						<div class="control">
							<div class=" tags has-addons pub_id {$pubIdPlugin->getPubIdType()|escape}">
								<span class="tag is-dark type">
									{$pubIdPlugin->getPubIdDisplayType()|escape}:
								</span>
								<span class="tag is-link id">
									{if $doiUrl}
										<a href="{$doiUrl|escape}">
											{$doiUrl}
										</a>
									{else}
										{$pubId}
									{/if}
								</span>
							</div>
						</div>
					{/if}
				{/foreach}
			</div>



			{* Full-issue galleys *}
			{if $issueGalleys}
				<div class="galleys content">
					<p class="subtitle" id="issueTocGalleyLabel">
						{translate key="issue.fullIssue"}
						</{$heading}>
					<div class="galleys_links field is-grouped">
						{foreach from=$issueGalleys item=galley}
							<div class="control">
								{include file="frontend/objects/galley_link.tpl" parent=$issue labelledBy="issueTocGalleyLabel" purchaseFee=$currentJournal->getData('purchaseIssueFee') purchaseCurrency=$currentJournal->getData('currency')}
							</div>
						{/foreach}
					</div>
				</div>
			{/if}

		</div>
		<div class="column is-3">

		</div>
	</div>

	{* Articles *}
	<div class="sections">
		{foreach name=sections from=$publishedSubmissions item=section}
			<div class="">
				{if $section.articles}
					{if $section.title}
						<{$sectionHeading}>
							{$section.title|escape}
						</{$sectionHeading}>
					{/if}
					<ul class="cmp_article_list articles">
						{foreach from=$section.articles item=article}
							<li class="mb-6 mt-6 pb-3">
								{include file="frontend/objects/article_summary.tpl" heading=$articleHeading}
							</li>
							
						{/foreach}

					</ul>
					<div class="divider is-right"></div>
				{/if}
			</div>
		{/foreach}
	</div><!-- .sections -->
</div>