{**
 * templates/frontend/objects/article_summary.tpl
 *
 * Copyright (c) 2014-2021 Simon Fraser University
 * Copyright (c) 2003-2021 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief View of an Article summary which is shown within a list of articles.
 *
 * @uses $article Article The article
 * @uses $hasAccess bool Can this user access galleys for this context? The
 *       context may be an issue or an article
 * @uses $showDatePublished bool Show the date this article was published?
 * @uses $hideGalleys bool Hide the article galleys for this article?
 * @uses $primaryGenreIds array List of file genre ids for primary file types
 * @uses $heading string HTML heading element, default: h2
 *}
{assign var=articlePath value=$article->getBestId()}
{if !$heading}
	{assign var="heading" value="h3"}
{/if}

{if (!$section.hideAuthor && $article->getHideAuthor() == $smarty.const.AUTHOR_TOC_DEFAULT) || $article->getHideAuthor() == $smarty.const.AUTHOR_TOC_SHOW}
	{assign var="showAuthor" value=true}
{/if}

{assign var=publication value=$article->getCurrentPublication()}

<div class="obj_article_summary">
	<div class="columns">

		{if $publication->getLocalizedData('coverImage')}
			<div class="column is-two-fifths">
				<div class="cover">
					<a {if $journal}href="{url journal=$journal->getPath() page="article" op="view" path=$articlePath}"
						{else}href="


							{url page="article" op="view" path=$articlePath}" 
						{/if} class="file">
						{assign var="coverImage" value=$publication->getLocalizedData('coverImage')}
						<img src="{$publication->getLocalizedCoverImageUrl($article->getData('contextId'))|escape}"
							alt="{$coverImage.altText|escape|default:''}">
					</a>
				</div>
			</div>
		{/if}

		<div class="column">
			<{$heading}>
				<a id="article-{$article->getId()}"
					{if $journal}href="{url journal=$journal->getPath() page="article" op="view" path=$articlePath}"
					{else}href="


						{url page="article" op="view" path=$articlePath}" 
					{/if}>
					{$article->getLocalizedTitle()|strip_unsafe_html}
					{if $article->getLocalizedSubtitle()}
						<span class="subtitle">
							{$article->getLocalizedSubtitle()|escape}
						</span>
					{/if}
				</a>
			</{$heading}>
			{if $showAuthor}
				<div class="authors">
					{$article->getAuthorString()|escape}
				</div>
			{/if}

		</div>
	</div>

	{assign var=submissionPages value=$publication->getData('pages')}
	{assign var=submissionDatePublished value=$publication->getData('datePublished')}
	{if $showAuthor || $submissionPages || ($submissionDatePublished && $showDatePublished)}
		<div class="meta content mb-3">
			{* Page numbers for this article *}
			{if $submissionPages}
				<div class="published tags has-addons">
					<div class="tag">Pag.</div>
					<div class="tag is-light is-primary">{$submissionPages|escape}</div>
				</div>
			{/if}

			{if $showDatePublished && $submissionDatePublished}
				<div class="published">
					{$submissionDatePublished|date_format:$dateFormatShort}
				</div>
			{/if}

		</div>
	{/if}

	{if !$hideGalleys}
		<div class="galleys_links buttons">
			{foreach from=$article->getGalleys() item=galley}
				{if $primaryGenreIds}
					{assign var="file" value=$galley->getFile()}
					{if !$galley->getRemoteUrl() && !($file && in_array($file->getGenreId(), $primaryGenreIds))}
						{continue}
					{/if}
				{/if}
				{assign var="hasArticleAccess" value=$hasAccess}
				{if $currentContext->getSetting('publishingMode') == $smarty.const.PUBLISHING_MODE_OPEN || $publication->getData('accessStatus') == $smarty.const.ARTICLE_ACCESS_OPEN}
					{assign var="hasArticleAccess" value=1}
				{/if}
				{include file="frontend/objects/galley_link.tpl" parent=$article publication=$publication labelledBy="article-{$article->getId()}"
				hasAccess=$hasArticleAccess purchaseFee=$currentJournal->getData('purchaseArticleFee')
				purchaseCurrency=$currentJournal->getData('currency')}
			{/foreach}
		</div>
	{/if}

	{call_hook name="Templates::Issue::Issue::Article"}


</div>