{**
 * templates/frontend/pages/indexJournal.tpl
 *
 * Copyright (c) 2014-2021 Simon Fraser University
 * Copyright (c) 2003-2021 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Display the index page for a journal
 *
 * @uses $currentJournal Journal This journal
 * @uses $journalDescription string Journal description from HTML text editor
 * @uses $homepageImage object Image to be displayed on the homepage
 * @uses $additionalHomeContent string Arbitrary input from HTML text editor
 * @uses $announcements array List of announcements
 * @uses $numAnnouncementsHomepage int Number of announcements to display on the
 *       homepage
 * @uses $issue Issue Current issue
 *}
{include file="frontend/components/header.tpl" pageTitleTranslated=$currentJournal->getLocalizedName()}

<div class="page_index_journal">

	<section class="hero is-primary ">
		{call_hook name="Templates::Index::journal"}

		<div class="hero-body">
			{if !$activeTheme->getOption('useHomepageImageAsHeader') && $homepageImage}
				<div class="homepage_image container has-text-centered">
				<p class="title">
				{$displayPageHeaderTitle|escape}</a>
				</p>
					{* <img src="{$publicFilesDir}/{$homepageImage.uploadName|escape:"url"}" {if $homepageImage.altText}
						alt="{$homepageImage.altText|escape}" {/if}> *}
				</div>
			{/if}

			{* Journal Description *}
			{if $activeTheme->getOption('showDescriptionInJournalIndex')}
				<section class="homepage_about">
					<a id="homepageAbout"></a>
					{* <h2>{translate key="about.aboutContext"}</h2> *}
					{$currentContext->getLocalizedData('description')}
				</section>
			{/if}
		</div>

		<div class="hero-foot">
{* Announcements *}
{if $numAnnouncementsHomepage && $announcements|@count}
	<div class="hero-foot">
	<section class="cmp_announcements highlight_first">
		<a id="homepageAnnouncements"></a>
		<h2>
			{translate key="announcement.announcements"}
		</h2>
		{foreach name=announcements from=$announcements item=announcement}
			{if $smarty.foreach.announcements.iteration > $numAnnouncementsHomepage}
				{break}
			{/if}
			{if $smarty.foreach.announcements.iteration == 1}
				{include file="frontend/objects/announcement_summary.tpl" heading="h3"}
				<div class="more">
			{else}
				<article class="obj_announcement_summary">
					<h4>
						<a href="{url router=$smarty.const.ROUTE_PAGE page="announcement" op="view" path=$announcement->getId()}">
							{$announcement->getLocalizedTitle()|escape}
						</a>
					</h4>
					<div class="date">
						{$announcement->getDatePosted()|date_format:$dateFormatShort}
					</div>
				</article>
			{/if}
		{/foreach}
		</div><!-- .more -->
	</section>
	</div>
{/if}
		</div>

	</section>

<div>

<span class="icon-text has-text-info">
  <span class="icon">
    <i class="fas fa-info-circle"></i>
  </span>
  <span>Info</span>
</span>

<span class="icon-text has-text-success">
  <span class="icon">
    <i class="fas fa-check-square"></i>
  </span>
  <span>Success</span>
</span>

<span class="icon-text has-text-warning">
  <span class="icon">
    <i class="fas fa-exclamation-triangle"></i>
  </span>
  <span>Warning</span>
</span>

<span class="icon-text has-text-danger">
  <span class="icon">
    <i class="fas fa-ban"></i>
  </span>
  <span>Danger</span>
</span>

</div>
	
	{* Latest issue *}
	{if $issue}
		<section class="current_issue">
			<a id="homepageIssue"></a>
			<h2>
				{translate key="journal.currentIssue"}
			</h2>
			<div class="current_issue_title">
				{$issue->getIssueIdentification()|strip_unsafe_html}
			</div>
			{include file="frontend/objects/issue_toc.tpl" heading="h3"}
			<a href="{url router=$smarty.const.ROUTE_PAGE page="issue" op="archive"}" class="read_more">
				{translate key="journal.viewAllIssues"}
			</a>
		</section>
	{/if}

	{* Additional Homepage Content *}
	{if $additionalHomeContent}
		<div class="additional_content">
			{$additionalHomeContent}
		</div>
	{/if}
</div><!-- .page -->

{include file="frontend/components/footer.tpl"}