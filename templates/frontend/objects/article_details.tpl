{**
 * templates/frontend/objects/article_details.tpl
 *
 * Copyright (c) 2014-2021 Simon Fraser University
 * Copyright (c) 2003-2021 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief View of an Article which displays all details about the article.
 *  Expected to be primary object on the page.
 *
 * Many journals will want to add custom data to this object, either through
 * plugins which attach to hooks on the page or by editing the template
 * themselves. In order to facilitate this, a flexible layout markup pattern has
 * been implemented. If followed, plugins and other content can provide markup
 * in a way that will render consistently with other items on the page. This
 * pattern is used in the .main_entry column and the .entry_details column. It
 * consists of the following:
 *
 * <!-- Wrapper class which provides proper spacing between components -->
 * <div class="item">
 *     <!-- Title/value combination -->
 *     <div class="label">Abstract</div>
 *     <div class="value">Value</div>
 * </div>
 *
 * All styling should be applied by class name, so that titles may use heading
 * elements (eg, <h3>) or any element required.
 *
 * <!-- Example: component with multiple title/value combinations -->
 * <div class="item">
 *     <div class="sub_item">
 *         <div class="label">DOI</div>
 *         <div class="value">12345678</div>
 *     </div>
 *     <div class="sub_item">
 *         <div class="label">Published Date</div>
 *         <div class="value">2015-01-01</div>
 *     </div>
 * </div>
 *
 * <!-- Example: component with no title -->
 * <div class="item">
 *     <div class="value">Whatever you'd like</div>
 * </div>
 *
 * Core components are produced manually below, but can also be added via
 * plugins using the hooks provided:
 *
 * Templates::Article::Main
 * Templates::Article::Details
 *
 * @uses $article Submission This article
 * @uses $publication Publication The publication being displayed
 * @uses $firstPublication Publication The first published version of this article
 * @uses $currentPublication Publication The most recently published version of this article
 * @uses $issue Issue The issue this article is assigned to
 * @uses $section Section The journal section this article is assigned to
 * @uses $categories Category The category this article is assigned to
 * @uses $primaryGalleys array List of article galleys that are not supplementary or dependent
 * @uses $supplementaryGalleys array List of article galleys that are supplementary
 * @uses $keywords array List of keywords assigned to this article
 * @uses $pubIdPlugins Array of pubId plugins which this article may be assigned
 * @uses $licenseTerms string License terms.
 * @uses $licenseUrl string URL to license. Only assigned if license should be
 *   included with published submissions.
 * @uses $ccLicenseBadge string An image and text with details about the license
 *}
{if !$heading}
	{assign var="heading" value="h3"}
{/if}
<article class="obj_article_details">

	{* Indicate if this is only a preview *}
	{if $publication->getData('status') !== $smarty.const.STATUS_PUBLISHED}
		<div class="message is-warning cmp_notification notice">
			{capture assign="submissionUrl"}{url page="workflow" op="access" path=$article->getId()}{/capture}
			{translate key="submission.viewingPreview" url=$submissionUrl}
		</div>
		{* Notification that this is an old version *}
	{elseif $currentPublication->getId() !== $publication->getId()}
		<div class="message is-warning cmp_notification notice">
			{capture assign="latestVersionUrl"}{url page="article" op="view" path=$article->getBestId()}{/capture}
			{translate key="submission.outdatedVersion"
							datePublished=$publication->getData('datePublished')|date_format:$dateFormatShort
							urlRecentVersion=$latestVersionUrl|escape
						}
		</div>
	{/if}

	<h1 class="page_title">
		{$publication->getLocalizedTitle()|escape}
	</h1>

	{if $publication->getLocalizedData('subtitle')}
		<h2 class="subtitle">
			{$publication->getLocalizedData('subtitle')|escape}
		</h2>
	{/if}

	{* {if $publication->getData('authors')}
					<div class="item authors">
						<h2 class="pkp_screen_reader">


		{translate key="article.authors"}</h2>
						<div class="authors">



		{foreach from=$publication->getData('authors') item=author}
											<strong>{$author->getFullName()|escape}</strong>,



		{/foreach}
						</div>
					</div>



	{/if} *}

	{* Authors full *}
	{if $publication->getData('authors')}
		<div class="item authors">
			<h2 class="label is-4 title">{translate key="article.authors"}</h2>
			<ul class="authors is-flex is-flex-direction-row is-flex-wrap-wrap">
				{foreach from=$publication->getData('authors') item=author name=artibleAuthor}
					<li class="block p-1">
						<div class="dropdown is-hoverable">
							<div class="dropdown-trigger">
								<button class=" button is-primary is-light name" aria-haspopup="true"
									aria-controls="dropdown-author-{$smarty.foreach.artibleAuthor.iteration}">
									<strong>{$author->getFullName()|escape}</strong>
								</button>
							</div>
							<div class="dropdown-menu" id="dropdown-author-{$smarty.foreach.artibleAuthor.iteration}"
								role="menu">
								<div class="dropdown-content">
									<div class="dropdown-item">

										{if $author->getData('orcid')}
											<p class="orcid">
												{if $author->getData('orcidAccessToken')}
													{$orcidIcon}
												{/if}
												<span class="tag is-link is-light"><a href="{$author->getData('orcid')|escape}"
														target="_blank">
														{$author->getData('orcid')|escape}
													</a></span>

											</p>
										{/if}
										{if $author->getLocalizedData('affiliation')}
											<p class="affiliation is-italic">
												{$author->getLocalizedData('affiliation')|escape}
												{if $author->getData('rorId')}
													<a href="{$author->getData('rorId')|escape}">{$rorIdIcon}</a>
												{/if}
											</p>
										{/if}
										{if $author->getLocalizedData('biography')}
											<div class="has-text-justified">
												{$author->getLocalizedData('biography')|strip_unsafe_html}</div>
										{/if}
									</div>
								</div>
							</div>
						</div>



					</li>
				{/foreach}
			</ul>
		</div>
	{/if}

	<div class="columns">
		<div class="column is-half">
			{* Article/Issue cover image *}
			{if $publication->getLocalizedData('coverImage') || ($issue && $issue->getLocalizedCoverImage())}
				<div class="item cover_image">
					<div class="sub_item">
						{if $publication->getLocalizedData('coverImage')}
							{assign var="coverImage" value=$publication->getLocalizedData('coverImage')}
							<img src="{$publication->getLocalizedCoverImageUrl($article->getData('contextId'))|escape}"
								alt="{$coverImage.altText|escape|default:''}">
						{else}
							<a href="{url page="issue" op="view" path=$issue->getBestIssueId()}">
								<img src="{$issue->getLocalizedCoverImageUrl()|escape}"
									alt="{$issue->getLocalizedCoverImageAltText()|escape|default:''}">
							</a>
						{/if}
					</div>
				</div>
			{/if}
			{if $publication->getData('datePublished')}
				<div class="item published">
					<div class="sub_item">
						<div class="published tags has-addons">
							<span class="tag is-dark">
								{translate key="submissions.published"}
							</span>
							{* If this is the original version *}
							{if $firstPublication->getID() === $publication->getId()}
								<span
									class="tag is-link">{$firstPublication->getData('datePublished')|date_format:$dateFormatShort}</span>
								{* If this is an updated version *}
							{else}
								<span
									class="tag is-link">{translate key="submission.updatedOn" datePublished=$firstPublication->getData('datePublished')|date_format:$dateFormatShort dateUpdated=$publication->getData('datePublished')|date_format:$dateFormatShort}</span>
							{/if}
							{if count($article->getPublishedPublications()) > 1}
								<div class="sub_item versions">
									<h2 class="label">
										{translate key="submission.versions"}
									</h2>
									<ul class="value">
										{foreach from=array_reverse($article->getPublishedPublications()) item=iPublication}
											{capture assign="name"}{translate key="submission.versionIdentity" datePublished=$iPublication->getData('datePublished')|date_format:$dateFormatShort version=$iPublication->getData('version')}{/capture}
											<li>
												{if $iPublication->getId() === $publication->getId()}
													{$name}
												{elseif $iPublication->getId() === $currentPublication->getId()}
													<a href="{url page="article" op="view" path=$article->getBestId()}">{$name}</a>
												{else}
													<a
														href="{url page="article" op="view" path=$article->getBestId()|to_array:"version":$iPublication->getId()}">{$name}</a>
												{/if}
											</li>
										{/foreach}
									</ul>
								</div>
							{/if}
						</div>
					</div>
				</div>
			{/if}

		</div>
		<div class="column">

			{* DOI (requires plugin) *}
			{foreach from=$pubIdPlugins item=pubIdPlugin}
				{if $pubIdPlugin->getPubIdType() != 'doi'}
					{continue}
				{/if}
				{assign var=pubId value=$article->getStoredPubId($pubIdPlugin->getPubIdType())}
				{if $pubId}
					{assign var="doiUrl" value=$pubIdPlugin->getResolvingURL($currentJournal->getId(), $pubId)|escape}
					<div class="item doi">
						<h2 class="label">
							{capture assign=translatedDOI}{translate key="plugins.pubIds.doi.readerDisplayName"}{/capture}
							{translate key="semicolon" label=$translatedDOI}
						</h2>
						<span class="value">
							<a href="{$doiUrl}">
								{$doiUrl}
							</a>
						</span>
					</div>
				{/if}
			{/foreach}

			{* PubIds (requires plugins) *}
			{foreach from=$pubIdPlugins item=pubIdPlugin}
				{if $pubIdPlugin->getPubIdType() == 'doi'}
					{continue}
				{/if}
				{assign var=pubId value=$article->getStoredPubId($pubIdPlugin->getPubIdType())}
				{if $pubId}
					<div class="item pubid">
						<h2 class="label title is-4">
							{$pubIdPlugin->getPubIdDisplayType()|escape}
						</h2>
						<div class="value">
							{if $pubIdPlugin->getResolvingURL($currentJournal->getId(), $pubId)|escape}
								<a id="pub-id::{$pubIdPlugin->getPubIdType()|escape}"
									href="{$pubIdPlugin->getResolvingURL($currentJournal->getId(), $pubId)|escape}">
									{$pubIdPlugin->getResolvingURL($currentJournal->getId(), $pubId)|escape}
								</a>
							{else}
								{$pubId|escape}
							{/if}
						</div>
					</div>
					<div class="divider is-right"></div>
				{/if}
			{/foreach}

			{* Issue article appears in *}
			{if $issue || $section || $categories}

				<div class="item issue">

					{if $issue}
						<div class="sub_item">
							<h2 class="label title is-4">
								{translate key="issue.issue"}
							</h2>
							<div class="value">
								<a class="is-5" href="{url page="issue" op="view" path=$issue->getBestIssueId()}">
									{$issue->getIssueIdentification()}
								</a>
							</div>
						</div>
					{/if}

					{if $section}
						<div class="sub_item">
							<h2 class="label title is-4">
								{translate key="section.section"}
							</h2>
							<div class="value">
								{$section->getLocalizedTitle()|escape}
							</div>
						</div>
					{/if}

					{if $categories}
						<div class="sub_item">
							<h2 class="label title is-4">
								{translate key="category.category"}
							</h2>
							<div class="value">
								<ul class="categories">
									{foreach from=$categories item=category}
										<li><a
												href="{url router=$smarty.const.ROUTE_PAGE page="catalog" op="category" path=$category->getPath()|escape}">{$category->getLocalizedTitle()|escape}</a>
										</li>
									{/foreach}
								</ul>
							</div>
						</div>
					{/if}
				</div>
				<div class="divider is-right"></div>
			{/if}


		</div>
	</div>


	{* Keywords *}
	{if !empty($publication->getLocalizedData('keywords'))}
		<div class="item keywords">
			<h2 class="label title is-4">
				{capture assign=translatedKeywords}{translate key="article.subject"}{/capture}
				{translate key="semicolon" label=$translatedKeywords}
			</h2>
			<div class="tags are-medium">
				{foreach name="keywords" from=$publication->getLocalizedData('keywords') item="keyword"}
					<span class="value tag is-primary is-light">
						{$keyword|escape}
					</span>
				{/foreach}
			</div>
		</div>
	{/if}

	{* Abstract *}
	{if $publication->getLocalizedData('abstract')}
		<div class="item abstract">
			<h2 class="label  title is-4">{translate key="article.abstract"}</h2>
			<div class="content has-text-justified">
				{$publication->getLocalizedData('abstract')|strip_unsafe_html}</div>
		</div>
	{/if}

	{* Article Galleys *}
	{if $primaryGalleys}
		<div class="item galleys">
			<h2 class="pkp_screen_reader">
				{translate key="submission.downloads"}
			</h2>
			<div class="value galleys_links buttons">
				{foreach from=$primaryGalleys item=galley}
					{include file="frontend/objects/galley_link.tpl" parent=$article publication=$publication galley=$galley purchaseFee=$currentJournal->getData('purchaseArticleFee') purchaseCurrency=$currentJournal->getData('currency')}
				{/foreach}
			</div>
		</div>
		<div class="divider is-right"></div>
	{/if}
	{if $supplementaryGalleys}
		<div class="item galleys">
			<h3 class="pkp_screen_reader">
				{translate key="submission.additionalFiles"}
			</h3>
			<div class="value supplementary_galleys_links buttons ">
				{foreach from=$supplementaryGalleys item=galley}
					{include file="frontend/objects/galley_link.tpl" parent=$article publication=$publication galley=$galley isSupplementary="1"}
				{/foreach}
			</div>
		</div>
		<div class="divider is-right"></div>
	{/if}

	{* Licensing info *}
	{if $currentContext->getLocalizedData('licenseTerms') || $publication->getData('licenseUrl')}

		<div class="item copyright">
			<h2 class="label title is-4">
				{translate key="submission.license"}
			</h2>
			{if $publication->getData('licenseUrl')}
				{if $ccLicenseBadge}
					{if $publication->getLocalizedData('copyrightHolder')}
						<p>{translate key="submission.copyrightStatement" copyrightHolder=$publication->getLocalizedData('copyrightHolder') copyrightYear=$publication->getData('copyrightYear')}
						</p>
					{/if}
					{$ccLicenseBadge}
				{else}
					<a href="{$publication->getData('licenseUrl')|escape}" class="copyright">
						{if $publication->getLocalizedData('copyrightHolder')}
							{translate key="submission.copyrightStatement" copyrightHolder=$publication->getLocalizedData('copyrightHolder') copyrightYear=$publication->getData('copyrightYear')}
						{else}
							{translate key="submission.license"}
						{/if}
					</a>
				{/if}
			{/if}
			{$currentContext->getLocalizedData('licenseTerms')}
		</div>
		<div class="divider is-right"></div>
	{/if}


	{* How to cite *}
	{if $citation}
		<div class="item citation">
			<div class="sub_item citation_display">
				<h2 class="label title is-4">
					{translate key="submission.howToCite"}
				</h2>
				<div class="value">
					<div id="citationOutput" class="content has-text-justified" role="region" aria-live="polite">
						{$citation}
					</div>
					<div class="citation_formats">
						<div class="dropdown is-hoverable">
							<div class="dropdown-trigger">
								<button class="cmp_button citation_formats_button" aria-controls="cslCitationFormats"
									aria-expanded="false" data-csl-dropdown="true">
									{translate key="submission.howToCite.citationFormats"}
								</button>
							</div>


							<div id="cslCitationFormats" class="dropdown-menu citation_formats_list" aria-hidden="true">
								<div class="dropdown-content">

									<ul class="citation_formats_styles">
										{foreach from=$citationStyles item="citationStyle"}
											<li>
												<a class="dropdown-item" aria-controls="citationOutput"
													href="{url page="citationstylelanguage" op="get" path=$citationStyle.id params=$citationArgs}"
													data-load-citation
													data-json-href="{url page="citationstylelanguage" op="get" path=$citationStyle.id params=$citationArgsJson}">
													{$citationStyle.title|escape}
												</a>
											</li>
										{/foreach}
									</ul>
									{if count($citationDownloads)}
										<hr class="dropdown-divider" />
										<div class="label dropdown-item">
											{translate key="submission.howToCite.downloadCitation"}
										</div>
										<ul class="citation_formats_styles">
											{foreach from=$citationDownloads item="citationDownload"}
												<li>
													<a class="dropdown-item"
														href="{url page="citationstylelanguage" op="download" path=$citationDownload.id params=$citationArgs}">
														<span class="fa fa-download"></span>
														{$citationDownload.title|escape}
													</a>
												</li>
											{/foreach}
										</ul>
									{/if}
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="divider is-right"></div>
		</div>
	{/if}

	{* References *}
	{call_hook name="Templates::Article::Main"}
	{if $parsedCitations || $publication->getData('citationsRaw')}
		<div class="item references">
			<h2 class="label  title is-4">
				{translate key="submission.citations"}
			</h2>
			<div class="value content has-text-justified">
				{if $parsedCitations}
					<ol type="1" class="">
						{foreach from=$parsedCitations item="parsedCitation"}
							<li class="">{$parsedCitation->getCitationWithLinks()|strip_unsafe_html}
								{call_hook name="Templates::Article::Details::Reference" citation=$parsedCitation}</li>
						{/foreach}
					</ol>
				{else}
					{$publication->getData('citationsRaw')|escape|nl2br}
				{/if}
			</div>
		</div>
		<div class="divider is-right"></div>
	{/if}


	{call_hook name="Templates::Article::Details"}

</article>