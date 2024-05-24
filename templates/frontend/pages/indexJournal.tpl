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

	{* Announcements *}
	{if $numAnnouncementsHomepage && $announcements|@count}

		<section class="section cmp_announcements highlight_first">
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
								<a
									href="{url router=$smarty.const.ROUTE_PAGE page="announcement" op="view" path=$announcement->getId()}">
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
			<div class="divider is-left"></div>
		</section>
	{/if}

	

	{* Latest issue *}
	{if $issue}
		<section class="section current_issue">
			<a id="homepageIssue"></a>
			<h2 class="title">
				{translate key="journal.currentIssue"}
			</h2>
			
			{include file="frontend/objects/issue_toc.tpl" heading="h3" showTitle="true"}
			<a href="{url router=$smarty.const.ROUTE_PAGE page="issue" op="archive"}" class="read_more button is-primary">
				{translate key="journal.viewAllIssues"}
			</a>

			<div class="divider is-right"></div>
		</section>
	{/if}

	{* Additional Homepage Content *}
	{if $additionalHomeContent}
		<div class="section additional_content">
			{$additionalHomeContent}
		</div>
	{/if}
</div><!-- .page -->

{include file="frontend/components/footer.tpl"}